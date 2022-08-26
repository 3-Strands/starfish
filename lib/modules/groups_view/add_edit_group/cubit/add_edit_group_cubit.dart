import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/repositories/error_repository.dart';
import 'package:starfish/repositories/model_wrappers/user_with_group_role.dart';
import 'package:starfish/src/deltas.dart';
import 'package:starfish/src/generated/file_transfer.pbgrpc.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/utils/helpers/uuid_generator.dart';
import 'package:starfish/wrappers/sms.dart';
import 'package:template_string/template_string.dart';

part 'add_edit_group_state.dart';

class AddEditGroupCubit extends Cubit<AddEditGroupState> {
  AddEditGroupCubit({
    required DataRepository dataRepository,
    required ErrorRepository errorRepository,
    Group? group,
  })  : _group = group,
        _dataRepository = dataRepository,
        _errorRepository = errorRepository,
        super(AddEditGroupState(
          languages: dataRepository.currentLanguages,
          evaluationCategories: dataRepository.currentEvaluationCategories,
          selectedLanguages: group?.languageIds.toSet() ?? const {},
          selectedEvaluationCategories:
              group?.evaluationCategoryIds.toSet() ?? const {},
          name: group?.name ?? '',
          description: group?.description ?? '',
          currentMembers: group?.users.toSet() ?? const {},
          history: group?.editHistory ?? const [],
        )) {
    _subscriptions = [
      dataRepository.languages
          .listen((languages) => emit(state.copyWith(languages: languages))),
      dataRepository.evaluationCategories.listen((evaluationCategories) =>
          emit(state.copyWith(evaluationCategories: evaluationCategories))),
    ];
  }

  late List<StreamSubscription> _subscriptions;
  final DataRepository _dataRepository;
  final ErrorRepository _errorRepository;
  final Group? _group;

  void selectedLanguagesChanged(Set<String> ids) =>
      emit(state.copyWith(selectedLanguages: ids));

  void selectedEvaluationCategoriesChanged(Set<String> ids) =>
      emit(state.copyWith(selectedEvaluationCategories: ids));

  void nameChanged(String name) => emit(state.copyWith(name: name));

  void descriptionChanged(String description) =>
      emit(state.copyWith(description: description));

  void newUsersAddedFromContacts(Set<User> users) => emit(
        state.copyWith(
          newMembers: state.newMembers.union(
            users
                .map((user) => UserWithGroupRole(user, GroupUser_Role.LEARNER))
                .toSet(),
          ),
        ),
      );

  ContactError? personNameSubmitted(String name) {
    if (name.isEmpty) {
      return null;
    }
    final lowerCaseName = name.toLowerCase();

    if (state.currentMembers.any((groupUser) =>
            groupUser.user.name.toLowerCase() == lowerCaseName) ||
        state.newMembers
            .any((member) => member.user.name.toLowerCase() == lowerCaseName)) {
      return ContactError.nameAlreadyExists;
    }
    emit(state.copyWith(newMembers: {
      ...state.newMembers,
      UserWithGroupRole(
        User(
          id: UuidGenerator.uuid(),
          name: name,
        ),
        GroupUser_Role.LEARNER,
      )
    }));
    return null;
  }

  void userNumberAdded(User user, String diallingCode, String phoneNumber) {
    emit(state.copyWith(
      diallingCodeChanges: {
        ...state.diallingCodeChanges,
        user.id: diallingCode,
      },
      phoneChanges: {
        ...state.phoneChanges,
        user.id: phoneNumber,
      },
    ));
  }

  bool _hasOtherAdminBesides(User user) =>
      state.currentMembers.any((groupUser) =>
          groupUser.userId != user.id &&
          (state.roleChanges[groupUser.userId] ?? groupUser.role) ==
              GroupUser_Role.ADMIN) ||
      state.newMembers.any((member) =>
          member.user != user && member.role == GroupUser_Role.ADMIN);

  void userRoleChanged(User user, GroupUser_Role role) {
    if (role != GroupUser_Role.ADMIN && !_hasOtherAdminBesides(user)) {
      _errorRepository.addUserFacingError(ErrorType.groupMustHaveAdmin,
          severity: Severity.high);
      return;
    }
    if (state.currentMembers.any((groupUser) => groupUser.userId == user.id)) {
      emit(state.copyWith(
        roleChanges: {
          ...state.roleChanges,
          user.id: role,
        },
      ));
    } else {
      emit(state.copyWith(
        newMembers: {...state.newMembers}
          ..removeWhere((member) => member.user == user)
          ..add(UserWithGroupRole(user, role)),
      ));
    }
  }

  void userUpdated(
    User user, {
    required String name,
    required String diallingCode,
    required String phone,
    required GroupUser_Role role,
  }) {
    if (state.currentMembers.any((groupUser) => groupUser.userId == user.id)) {
      emit(state.copyWith(
        roleChanges: {
          ...state.roleChanges,
          user.id: role,
        },
        nameChanges: {
          ...state.nameChanges,
          user.id: name,
        },
        diallingCodeChanges: {
          ...state.diallingCodeChanges,
          user.id: diallingCode,
        },
        phoneChanges: {
          ...state.phoneChanges,
          user.id: phone,
        },
      ));
    } else {
      emit(state.copyWith(
        newMembers: {...state.newMembers}
          ..removeWhere((member) => member.user == user)
          ..add(
            UserWithGroupRole(
              User(
                id: user.id,
                name: name,
                diallingCode: diallingCode,
                phone: phone,
              ),
              role,
            ),
          ),
      ));
    }
  }

  void userRemoved(User user) {
    if (!_hasOtherAdminBesides(user)) {
      _errorRepository.addUserFacingError(ErrorType.groupMustHaveAdmin,
          severity: Severity.high);
      return;
    }
    final groupUserMatchesUser =
        (GroupUser groupUser) => groupUser.userId == user.id;
    final memberMatchesUser =
        (UserWithGroupRole member) => member.user.id == user.id;
    print(user);
    print(state.currentMembers);
    print(state.newMembers);
    if (state.currentMembers.any(groupUserMatchesUser)) {
      // We only mark this item for permanent deletion if it was previously
      // saved.
      emit(state.copyWith(
        currentMembers: {...state.currentMembers}
          ..removeWhere(groupUserMatchesUser),
        removedMembers: {...state.removedMembers, user},
      ));
    } else {
      emit(state.copyWith(
        newMembers: {...state.newMembers}..removeWhere(memberMatchesUser),
      ));
    }
  }

  bool submitRequested(String message) {
    GroupError? error;
    if (state.name.isEmpty) {
      error = GroupError.noName;
    } else if (state.description.isEmpty) {
      error = GroupError.noDescription;
    }

    if (error != null) {
      emit(state.copyWith(error: error));
      return false;
    }
    final group = _group;
    final isCreate = group == null;
    final id = group?.id ?? UuidGenerator.uuid();
    _dataRepository.addDelta(
      isCreate
          ? GroupCreateDelta(
              id: id,
              name: state.name,
              description: state.description,
              languageIds: state.selectedLanguages.toList(),
              evaluationCategoryIds:
                  state.selectedEvaluationCategories.toList(),
            )
          : GroupUpdateDelta(
              group,
              name: state.name,
              description: state.description,
              languageIds: state.selectedLanguages.toList(),
              evaluationCategoryIds:
                  state.selectedEvaluationCategories.toList(),
            ),
    );

    // If we just added this group, add ourselves to it.
    if (isCreate) {
      _dataRepository.addDelta(GroupUserCreateDelta(
        userId: _dataRepository.currentUser.id,
        groupId: id,
        role: GroupUser_Role.ADMIN,
      ));
    }

    for (final groupUser in state.currentMembers) {
      final user = groupUser.user;
      _dataRepository.addDelta(
          GroupUserUpdateDelta(groupUser, role: state.roleChanges[user.id]));
      _dataRepository.addDelta(UserUpdateDelta(
        user,
        phone: state.phoneChanges[user.id],
        diallingCode: state.diallingCodeChanges[user.id],
        name: state.nameChanges[user.id],
      ));
      if (state.phoneChanges.containsKey(user.id) ||
          state.diallingCodeChanges.containsKey(user.id)) {
        _sendSMS(message, user.fullPhone, user.name);
      }
    }
    for (final userWithRole in state.newMembers) {
      final user = userWithRole.user;
      final userId = UuidGenerator.uuid();
      _dataRepository.addDelta(UserCreateDelta(
        id: userId,
        name: user.name,
        phone: user.phone,
        diallingCode: user.diallingCode,
      ));
      _dataRepository.addDelta(GroupUserCreateDelta(
        userId: userId,
        groupId: id,
        role: userWithRole.role,
      ));
      if (user.hasFullPhone) {
        _sendSMS(message, user.fullPhone, user.name);
      }
    }

    return true;
  }

  void _sendSMS(String message, String number, String to) {
    SMS.send(
      message.insertTemplateValues({
        'receiver_first_name': to,
        'sender_name': _dataRepository.currentUser.name,
      }),
      number,
    );
  }

  @override
  Future<void> close() {
    _subscriptions.forEach((subscription) => subscription.cancel());
    return super.close();
  }
}
