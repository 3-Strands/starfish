import 'package:starfish/src/generated/google/protobuf/field_mask.pb.dart';
import 'package:test/test.dart';
import 'package:hive/hive.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/src/deltas.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/src/grpc_adapters.dart';

void main() async {
  registerAllAdapters();
  setUp(() async {
    Hive.init('.db');
    await HiveApi.init(memoryOnly: false);
  });
  tearDown(() async {
    await Hive.deleteFromDisk();
  });

  test('simple create delta', () {
    final groupBox = globalHiveApi.group;
    final revertBox = globalHiveApi.revert;
    final syncBox = globalHiveApi.sync;

    GroupCreateDelta(id: '1234', name: 'My Group Name')..apply();

    expect(groupBox.length, 1);
    final group = groupBox.get('1234')!;
    expect(group.id, '1234');
    expect(group.name, 'My Group Name');

    expect(revertBox.length, 1);
    final groupChanges = revertBox.get(12)!;
    expect(groupChanges.keys.length, 1);
    expect(groupChanges.keys.first, '1234');
    expect(groupChanges['1234'], null);

    expect(syncBox.length, 1);
    final request = syncBox.values.first;
    expect(request is CreateUpdateGroupsRequest, true);
    expect(request.group.id, '1234');
    expect(request.group.name, 'My Group Name');
    expect(request.hasUpdateMask(), false);
  });

  test('simple update delta', () {
    final groupBox = globalHiveApi.group;
    final revertBox = globalHiveApi.revert;
    final syncBox = globalHiveApi.sync;

    final originalGroup =
        Group(id: '1234', name: 'My Group Name', linkEmail: 'old@domain.com')
          ..freeze();
    groupBox.put(originalGroup.id, originalGroup);

    GroupUpdateDelta(originalGroup,
        description: 'Some description', linkEmail: 'new@domain.com')
      ..apply();

    expect(groupBox.length, 1);
    final group = groupBox.get('1234')!;
    expect(group.id, '1234');
    expect(group.name, 'My Group Name');
    expect(group.description, 'Some description');
    expect(group.linkEmail, 'new@domain.com');

    expect(revertBox.length, 1);
    final groupChanges = revertBox.get(12)!;
    expect(groupChanges.keys.length, 1);
    expect(groupChanges['1234'], originalGroup);

    expect(syncBox.length, 1);
    final request = syncBox.values.first;
    expect(request is CreateUpdateGroupsRequest, true);
    expect(request.group.id, '1234');
    expect(request.group.name, 'My Group Name');
    expect(request.group.description, 'Some description');
    expect(request.group.linkEmail, 'new@domain.com');
    final updateMask = (request.updateMask as FieldMask).paths;
    expect(updateMask.length, 2);
    expect(updateMask.contains('description'), true);
    expect(updateMask.contains('link_email'), true);
  });

  test('simple delete delta', () {
    final actionBox = globalHiveApi.action;
    final revertBox = globalHiveApi.revert;
    final syncBox = globalHiveApi.sync;

    final action = Action(id: '1234', name: 'My Action Name')..freeze();
    actionBox.put(action.id, action);
    expect(actionBox.length, 1);

    ActionDeleteDelta(action)..apply();

    expect(actionBox.length, 0);

    expect(revertBox.length, 1);
    final actionChanges = revertBox.get(4)!;
    expect(actionChanges.keys.length, 1);
    expect(actionChanges['1234'], action);

    expect(syncBox.length, 1);
    final request = syncBox.values.first;
    expect(request is DeleteActionRequest, true);
    expect(request.actionId, '1234');
  });

  test('complex create delta', () {
    final groupBox = globalHiveApi.group;
    final userBox = globalHiveApi.user;
    final revertBox = globalHiveApi.revert;
    final syncBox = globalHiveApi.sync;

    groupBox.put('g1234', Group(id: 'g1234', name: 'My Group')..freeze());
    userBox.put('u5678', User(id: 'u5678', name: 'My User')..freeze());

    GroupUserCreateDelta(id: 'gu9012', groupId: 'g1234', userId: 'u5678')
      ..apply();

    expect(groupBox.length, 1);
    final group = groupBox.get('g1234')!;
    expect(group.id, 'g1234');
    expect(group.name, 'My Group');
    expect(group.users.length, 1);
    expect(group.users.first.id, 'gu9012');
    expect(userBox.length, 1);
    final user = userBox.get('u5678')!;
    expect(user.id, 'u5678');
    expect(user.name, 'My User');
    expect(user.groups.length, 1);
    expect(user.groups.first.id, 'gu9012');

    expect(revertBox.length, 2);
    final groupChanges = revertBox.get(12)!;
    expect(groupChanges.keys.length, 1);
    expect(groupChanges['g1234'] is Group, true);
    expect(groupChanges['g1234'].users.length, 0);
    final userChanges = revertBox.get(16)!;
    expect(userChanges.keys.length, 1);
    expect(userChanges['u5678'] is User, true);
    expect(userChanges['u5678'].groups.length, 0);

    expect(syncBox.length, 1);
    final request = syncBox.values.first;
    expect(request is CreateUpdateGroupUsersRequest, true);
    expect(request.groupUser.id, 'gu9012');
    expect(request.hasUpdateMask(), false);
  });

  test('complex update delta', () {
    final groupBox = globalHiveApi.group;
    final userBox = globalHiveApi.user;
    final revertBox = globalHiveApi.revert;
    final syncBox = globalHiveApi.sync;

    final originalGroupUser = GroupUser(
      id: 'gu9012',
      groupId: 'g1234',
      userId: 'u5678',
      profile: 'oldProfile',
      role: GroupUser_Role.TEACHER,
    );

    groupBox.put(
      'g1234',
      Group(id: 'g1234', name: 'My Group', users: [originalGroupUser])
        ..freeze(),
    );
    userBox.put(
      'u5678',
      User(id: 'u5678', name: 'My User', groups: [originalGroupUser])..freeze(),
    );

    GroupUserUpdateDelta(originalGroupUser,
        profile: 'newProfile', role: GroupUser_Role.TEACHER)
      ..apply();

    expect(groupBox.length, 1);
    final group = groupBox.get('g1234')!;
    expect(group.id, 'g1234');
    expect(group.name, 'My Group');
    expect(group.users.length, 1);
    expect(group.users.first.id, 'gu9012');
    expect(group.users.first.profile, 'newProfile');
    expect(group.users.first.role, GroupUser_Role.TEACHER);
    expect(userBox.length, 1);
    final user = userBox.get('u5678')!;
    expect(user.id, 'u5678');
    expect(user.name, 'My User');
    expect(user.groups.length, 1);
    expect(user.groups.first.id, 'gu9012');
    expect(user.groups.first.profile, 'newProfile');
    expect(user.groups.first.role, GroupUser_Role.TEACHER);

    expect(revertBox.length, 2);
    final groupChanges = revertBox.get(12)!;
    expect(groupChanges.keys.length, 1);
    expect(groupChanges['g1234'] is Group, true);
    expect(groupChanges['g1234'].users.length, 1);
    expect(groupChanges['g1234'].users.first.profile, 'oldProfile');
    final userChanges = revertBox.get(16)!;
    expect(userChanges.keys.length, 1);
    expect(userChanges['u5678'] is User, true);
    expect(userChanges['u5678'].groups.length, 1);
    expect(userChanges['u5678'].groups.first.profile, 'oldProfile');

    expect(syncBox.length, 1);
    final request = syncBox.values.first;
    expect(request is CreateUpdateGroupUsersRequest, true);
    expect(request.groupUser.id, 'gu9012');
    expect(request.groupUser.profile, 'newProfile');
    expect(request.updateMask.paths.length, 1);
    expect(request.updateMask.paths.first, 'profile');
  });

  test('complex delete delta', () {
    final groupBox = globalHiveApi.group;
    final userBox = globalHiveApi.user;
    final revertBox = globalHiveApi.revert;
    final syncBox = globalHiveApi.sync;

    final originalGroupUser = GroupUser(
      id: 'gu9012',
      groupId: 'g1234',
      userId: 'u5678',
    );

    groupBox.put(
      'g1234',
      Group(id: 'g1234', name: 'My Group', users: [originalGroupUser])
        ..freeze(),
    );
    userBox.put(
      'u5678',
      User(id: 'u5678', name: 'My User', groups: [originalGroupUser])..freeze(),
    );

    GroupUserDeleteDelta(originalGroupUser)..apply();

    expect(groupBox.length, 1);
    final group = groupBox.get('g1234')!;
    expect(group.id, 'g1234');
    expect(group.name, 'My Group');
    expect(group.users.length, 0);
    expect(userBox.length, 1);
    final user = userBox.get('u5678')!;
    expect(user.id, 'u5678');
    expect(user.name, 'My User');
    expect(user.groups.length, 0);

    expect(revertBox.length, 2);
    final groupChanges = revertBox.get(12)!;
    expect(groupChanges.keys.length, 1);
    expect(groupChanges['g1234'] is Group, true);
    expect(groupChanges['g1234'].users.length, 1);
    expect(groupChanges['g1234'].users.first.id, 'gu9012');
    final userChanges = revertBox.get(16)!;
    expect(userChanges.keys.length, 1);
    expect(userChanges['u5678'] is User, true);
    expect(userChanges['u5678'].groups.length, 1);
    expect(userChanges['u5678'].groups.first.id, 'gu9012');

    expect(syncBox.length, 1);
    final request = syncBox.values.first;
    expect(request is DeleteGroupUserRequest, true);
    expect(request.groupUserId, 'gu9012');
  });

  test('simple create + update delta', () {
    final groupBox = globalHiveApi.group;
    final revertBox = globalHiveApi.revert;
    final syncBox = globalHiveApi.sync;

    GroupCreateDelta(
        id: '1234', name: 'My Old Group', linkEmail: 'some@domain.com')
      ..apply();
    GroupUpdateDelta(groupBox.get('1234')!,
        name: 'My New Group', description: 'Some description')
      ..apply();

    expect(groupBox.length, 1);
    final group = groupBox.get('1234')!;
    expect(group.id, '1234');
    expect(group.name, 'My New Group');
    expect(group.description, 'Some description');
    expect(group.linkEmail, 'some@domain.com');

    expect(revertBox.length, 1);
    final groupChanges = revertBox.get(12)!;
    expect(groupChanges.keys.length, 1);
    expect(groupChanges.keys.first, '1234');
    expect(groupChanges['1234'], null);

    expect(syncBox.length, 1);
    final request = syncBox.values.first;
    expect(request is CreateUpdateGroupsRequest, true);
    expect(request.group.id, '1234');
    expect(request.group.name, 'My New Group');
    expect(group.description, 'Some description');
    expect(group.linkEmail, 'some@domain.com');
    expect(request.hasUpdateMask(), false);
  });

  test('simple create + delete delta', () {
    final actionBox = globalHiveApi.action;
    final revertBox = globalHiveApi.revert;
    final syncBox = globalHiveApi.sync;

    ActionCreateDelta(id: '1234', name: 'My Action')..apply();
    ActionDeleteDelta(actionBox.get('1234')!)..apply();

    expect(actionBox.length, 0);

    expect(revertBox.length, 1);
    final actionChanges = revertBox.get(4)!;
    expect(actionChanges.keys.length, 1);
    expect(actionChanges.keys.first, '1234');
    expect(actionChanges['1234'], null);

    expect(syncBox.length, 0);
  });

  test('simple update + update delta', () {
    final groupBox = globalHiveApi.group;
    final revertBox = globalHiveApi.revert;
    final syncBox = globalHiveApi.sync;

    groupBox.put(
      '1234',
      Group(id: '1234', name: 'My Old Group', linkEmail: 'old@domain.com')
        ..freeze(),
    );

    GroupUpdateDelta(groupBox.get('1234')!,
        name: 'My New Group', linkEmail: 'new@domain.com')
      ..apply();
    GroupUpdateDelta(groupBox.get('1234')!,
        name: 'My Newest Group', description: 'Some description')
      ..apply();

    expect(groupBox.length, 1);
    expect(
      groupBox.get('1234')!,
      Group(
        id: '1234',
        name: 'My Newest Group',
        description: 'Some description',
        linkEmail: 'new@domain.com',
      ),
    );

    expect(revertBox.length, 1);
    final groupChanges = revertBox.get(12)!;
    expect(groupChanges.keys.length, 1);
    expect(
      groupChanges['1234'],
      Group(
        id: '1234',
        name: 'My Old Group',
        linkEmail: 'old@domain.com',
      ),
    );

    expect(syncBox.length, 1);
    expect(
      syncBox.values.first,
      CreateUpdateGroupsRequest(
        group: Group(
          id: '1234',
          name: 'My Newest Group',
          description: 'Some description',
          linkEmail: 'new@domain.com',
        ),
        updateMask: FieldMask(
          paths: [
            'name',
            'description',
            'link_email',
          ],
        ),
      ),
    );
  });

  test('simple update + delete delta', () {
    final actionBox = globalHiveApi.action;
    final revertBox = globalHiveApi.revert;
    final syncBox = globalHiveApi.sync;

    actionBox.put(
      '1234',
      Action(
        id: '1234',
        name: 'My Old Action',
      )..freeze(),
    );

    ActionUpdateDelta(actionBox.get('1234')!, name: 'My New Action')..apply();
    ActionDeleteDelta(actionBox.get('1234')!)..apply();

    expect(actionBox.length, 0);

    expect(revertBox.length, 1);
    final actionChanges = revertBox.get(4)!;
    expect(actionChanges.keys.length, 1);
    expect(actionChanges.keys.first, '1234');
    expect(
      actionChanges['1234'],
      Action(
        id: '1234',
        name: 'My Old Action',
      ),
    );

    expect(syncBox.length, 1);
    expect(
      syncBox.values.first,
      DeleteActionRequest(
        actionId: '1234',
      ),
    );
  });

  test('ordering of sync deltas', () {
    ActionUserCreateDelta(id: '1234', actionId: '5678')..apply();
    ActionCreateDelta(id: '5678', name: 'My Action')..apply();

    expect(
        globalHiveApi.sync.values.first is CreateUpdateActionUserRequest, true);

    final inOrder = getRequestsInOrder();
    expect(inOrder.length, 2);
    expect(inOrder[0] is CreateUpdateActionsRequest, true);
    expect(inOrder[1] is CreateUpdateActionUserRequest, true);
  });
}
