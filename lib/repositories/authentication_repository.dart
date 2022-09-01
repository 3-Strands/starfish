import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:grpc/grpc.dart';
import 'package:rxdart/subjects.dart';
import 'package:starfish/apis/grpc_authentication_api.dart';
import 'package:starfish/apis/grpc_current_user_api.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/apis/local_storage_api.dart';
import 'package:starfish/models/tokens.dart';
import 'package:starfish/models/session.dart';
import 'package:starfish/src/generated/file_transfer.pbgrpc.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';
import 'package:starfish/utils/services/grpc_client.dart';

/// Thrown during authentication. If caught, check the [code] property
/// to display a locale-aware message.
class AuthenticationException implements Exception {
  const AuthenticationException(this.code);

  // TODO: check these code values.

  /// The code associated with this exception. It can have one of the
  /// following values:
  /// * account-exists-with-different-credential
  /// * invalid-credential
  /// * operation-not-allowed
  /// * user-disabled
  /// * user-not-found
  /// * wrong-password
  /// * invalid-verification-code
  /// * invalid-verification-id
  /// * code-auto-retrieval-timeout
  final String? code;
}

class OtpHandler {
  const OtpHandler({
    required this.authenticateWithCode,
    required this.resendOtp,
  });

  final Future<void> Function(String code) authenticateWithCode;
  final Future<OtpHandler?> Function() resendOtp;
}

typedef MakeCurrentUserApi = GrpcCurrentUserApi Function(Tokens session);

typedef MakeAuthenticatedRequest = Future<T> Function<T>(
    Future<T> Function(
            StarfishClient client, FileTransferClient fileTransferClient)
        makeRequest);

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthenticationRepository {
  /// {@macro authentication_repository}
  AuthenticationRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
    GrpcAuthenticationApi? grpcAuthenticationApi,
    LocalStorageApi? localStorageApi,
    MakeCurrentUserApi? makeCurrentUserApi,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _grpcAuthenticationApi = grpcAuthenticationApi ??
            GrpcAuthenticationApi(client: makeUnauthenticatedClient()),
        _localStorageApi = localStorageApi ?? LocalStorageApi(),
        _makeCurrentUserApi = makeCurrentUserApi ??
            ((Tokens tokens) => GrpcCurrentUserApi(
                client: makeAuthenticatedClient(tokens.accessToken))) {
    _session.stream.listen((session) {
      if (session != null) {
        _cacheSession(session);
      }
    });
    globalHiveApi.user.watch().listen((event) {
      final currentSession = _session.value;
      if (currentSession == null) {
        return;
      }
      final currentUserId = currentSession.user.id;
      if (event.key == currentUserId) {
        final updatedUser = globalHiveApi.user.get(currentUserId)!;
        if (updatedUser != currentSession.user) {
          _session.value = Session(currentSession.tokens, updatedUser);
        }
      }
    });
  }

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GrpcAuthenticationApi _grpcAuthenticationApi;
  final LocalStorageApi _localStorageApi;
  final MakeCurrentUserApi _makeCurrentUserApi;
  final BehaviorSubject<Session?> _session = BehaviorSubject.seeded(null);

  Future<void> _cacheSession(Session session) => Future.wait([
        _localStorageApi.saveTokens(session.tokens),
        _localStorageApi.saveUser(session.user),
      ]);

  Future<void> loadCurrentSessionIfExists() async {
    final tokens = await _localStorageApi.getTokens();
    if (tokens != null) {
      // TODO: sync user?
      final user = (await _localStorageApi.getUser()) ??
          (await _retrieveUserUsingTokens(tokens));
      _session.value = Session(tokens, user);
    }
  }

  /// Stream of [Session] which will emit the current session and user when
  /// the authentication state changes.
  ///
  /// Emits [null] if the user is not authenticated.
  Stream<Session?> get session => _session.stream;

  Session? get currentSession => _session.value;

  User getCurrentUser() => _session.value!.user;

  // BehaviorSubject<User> get currentUser => BehaviorSubject.from

  OtpHandler makeOtpHandler(
    Future<void> Function(String code) authenticateWithCode, {
    required String phoneNumber,
    int? resendToken,
  }) {
    return OtpHandler(
      authenticateWithCode: authenticateWithCode,
      resendOtp: () => authenticate(phoneNumber, resendToken: resendToken),
    );
  }

  Future<OtpHandler?> authenticate(String phoneNumber, {int? resendToken}) =>
      kIsWeb
          ? _authenticateOnWeb(phoneNumber)
          : _authenticateOnDevice(phoneNumber, resendToken: resendToken);

  Future<OtpHandler?> _authenticateOnDevice(String phoneNumber,
      {int? resendToken}) async {
    final completer = Completer<OtpHandler?>();
    _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
        try {
          final credential =
              await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          await _initializeSessionFromUserCredential(credential);
        } catch (error, stackTrace) {
          completer.completeError(error, stackTrace);
        }
      },
      verificationFailed: (firebaseException) => completer
          .completeError(AuthenticationException(firebaseException.code)),
      codeSent: (String verificationId, int? resendToken) {
        completer.complete(makeOtpHandler((code) async {
          final phoneAuthCredential = PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: code,
          );
          final userCredential =
              await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          await _initializeSessionFromUserCredential(userCredential);
        }, phoneNumber: phoneNumber, resendToken: resendToken));
      },
      timeout: const Duration(seconds: 60),
      forceResendingToken: resendToken,
      codeAutoRetrievalTimeout: (String verificationId) {
        completer.completeError(
            AuthenticationException('code-auto-retrieval-timeout'));
      },
    );

    return completer.future;
  }

  Future<OtpHandler?> _authenticateOnWeb(String phoneNumber) async {
    final result = await _firebaseAuth.signInWithPhoneNumber(phoneNumber);
    return makeOtpHandler((code) async {
      final credential = await result.confirm(code);
      await _initializeSessionFromUserCredential(credential);
    }, phoneNumber: phoneNumber);
  }

  Future<void> _initializeSessionFromUserCredential(
      firebase_auth.UserCredential credential) async {
    final firebaseUser = credential.user!;
    // Authenticate with GRPC
    final tokens = await _grpcAuthenticationApi.authenticate(
        await firebaseUser.getIdToken(), firebaseUser.phoneNumber!);
    // Initialize HiveCurrentUser
    final user = await _retrieveUserUsingTokens(tokens);
    _session.value = Session(tokens, user,
        needsProfileCreation:
            user.languageIds.isEmpty && user.countryIds.isEmpty);
  }

  Future<User> _retrieveUserUsingTokens(Tokens tokens) =>
      _makeCurrentUserApi(tokens).getCurrentUser();

  Completer<Session>? _sessionRefreshCompleter;

  Future<Session> refreshSession() {
    if (_sessionRefreshCompleter != null) {
      return _sessionRefreshCompleter!.future;
    }
    _sessionRefreshCompleter = Completer();
    _doRefreshSession()
        .then(_sessionRefreshCompleter!.complete)
        .onError(_sessionRefreshCompleter!.completeError)
        .whenComplete(() => _sessionRefreshCompleter = null);
    return _sessionRefreshCompleter!.future;
  }

  Future<Session> _doRefreshSession() async {
    final currentSession = this.currentSession!;
    final newTokens =
        await _grpcAuthenticationApi.refreshTokens(currentSession.tokens);
    final session = Session(newTokens, currentSession.user);
    _session.value = session;
    return session;
  }

  void updateCurrentUser(User user) {
    _session.value = Session(_session.value!.tokens, user);
  }

  Future<T> makeAuthenticatedRequest<T>(
      Future<T> Function(
              StarfishClient client, FileTransferClient fileTransferClient)
          makeRequest) async {
    assert(_session.value != null,
        'Attempting to make an authenticated request without a valid session!');
    var client = makeAuthenticatedClient(_session.value!.tokens.accessToken);
    var fileTransferClient =
        makeAuthenticatedFileTransferClient(_session.value!.tokens.accessToken);
    try {
      return await makeRequest(client, fileTransferClient);
    } on GrpcError catch (error) {
      if (error.code == StatusCode.unauthenticated) {
        final newSession = await refreshSession();
        client = makeAuthenticatedClient(newSession.tokens.accessToken);
        fileTransferClient =
            makeAuthenticatedFileTransferClient(newSession.tokens.accessToken);
        return await makeRequest(client, fileTransferClient);
      } else {
        throw error;
      }
    }
  }

  Future<T> makeAuthenticatedFileTransferRequest<T>(
      Future<T> Function(FileTransferClient client) makeRequest) async {
    assert(_session.value != null,
        'Attempting to make an authenticated request without a valid session!');
    var client =
        makeAuthenticatedFileTransferClient(_session.value!.tokens.accessToken);
    try {
      return await makeRequest(client);
    } on GrpcError catch (error) {
      if (error.code == StatusCode.unauthenticated) {
        final newSession = await refreshSession();
        client =
            makeAuthenticatedFileTransferClient(newSession.tokens.accessToken);
        return await makeRequest(client);
      } else {
        throw error;
      }
    }
  }
}
