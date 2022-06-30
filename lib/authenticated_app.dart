import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starfish/bloc/session_bloc.dart';
import 'package:starfish/repositories/grpc_repository.dart';
import 'package:starfish/repositories/sync_repository.dart';
import 'package:starfish/utils/services/grpc_client.dart';

class AuthenticatedApp extends StatelessWidget {
  const AuthenticatedApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) {
        final sessionState = BlocProvider.of<SessionBloc>(context).state as SessionActive;
        final token = sessionState.session.accessToken;
        return GrpcRepository(
          client: makeAuthenticatedClient(token),
          fileTransferClient: makeAuthenticatedFileTransferClient(token),
        );
      },
      child: RepositoryProvider(
        create: (context) {
          final grpcRepository = RepositoryProvider.of<GrpcRepository>(context);
          return SyncRepository(
            grpcRepository: grpcRepository,
          );
        },
        child: const AuthenticatedAppView(),
      ),
    );
  }
}

class AuthenticatedAppView extends StatelessWidget {
  const AuthenticatedAppView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        
      },
    );
  }
}
