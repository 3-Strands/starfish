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
    MaterialCreateDelta(id: '5678')..apply();
    GroupCreateDelta(id: '1234')..apply();

    expect(globalHiveApi.sync.values.first is CreateUpdateGroupsRequest, true);

    final inOrder = orderRequests(globalHiveApi.sync.values);
    expect(inOrder.length, 2);
    expect(inOrder[0] is CreateUpdateMaterialsRequest, true);
    expect(inOrder[1] is CreateUpdateGroupsRequest, true);
  });

  test('correctly reverts created records', () {
    GroupCreateDelta(id: '5678', name: 'My Group')..apply();
    UserCreateDelta(id: '9012', name: 'My User')..apply();
    GroupUserCreateDelta(id: '1234', groupId: '5678', userId: '9012')..apply();

    expect(globalHiveApi.group.length, 1);
    expect(
        globalHiveApi.group.get('5678'),
        Group(
          id: '5678',
          name: 'My Group',
          users: [
            GroupUser(id: '1234', groupId: '5678', userId: '9012'),
          ],
        ));

    expect(globalHiveApi.user.length, 1);
    expect(
        globalHiveApi.user.get('9012'),
        User(
          id: '9012',
          name: 'My User',
          groups: [
            GroupUser(id: '1234', groupId: '5678', userId: '9012'),
          ],
        ));

    revertAll();

    expect(globalHiveApi.group.length, 0);
    expect(globalHiveApi.user.length, 0);
  });

  test('correctly reverts edited records', () {
    final originalAction = Action(id: '1234', name: 'My Action')..freeze();

    globalHiveApi.action.put('1234', originalAction);

    ActionUpdateDelta(originalAction, name: 'My New Action')..apply();

    expect(
        globalHiveApi.action.get('1234'),
        Action(
          id: '1234',
          name: 'My New Action',
        ));

    revertAll();

    expect(
      globalHiveApi.action.get('1234'),
      originalAction,
    );
  });

  test('correctly reverts deleted records', () {
    final originalAction = Action(id: '1234', name: 'My Action')..freeze();

    globalHiveApi.action.put('1234', originalAction);

    ActionDeleteDelta(originalAction)..apply();

    expect(globalHiveApi.action.get('1234'), null);

    revertAll();

    expect(
      globalHiveApi.action.get('1234'),
      originalAction,
    );
  });

  test('correctly handles deltas applied during sync', () async {
    final originalAction = Action(
      id: '1234',
      name: 'My Original Action',
      instructions: 'Some instructions',
    )..freeze();
    final deletableAction = Action(
      id: '5678',
      name: 'My Deletable Action',
    )..freeze();

    globalHiveApi.action.put('1234', originalAction);
    globalHiveApi.action.put('5678', deletableAction);

    // Apply two updates: a create and an update
    ActionCreateDelta(id: '9012', name: 'My Other Action')..apply();
    ActionUpdateDelta(
      originalAction,
      name: 'My Updated Original Action',
      instructions: 'Some instructions',
    )..apply();

    // Don't apply these just yet
    final addOneMoreDelta = ActionCreateDelta(
      id: '3456',
      name: 'My Newest Action',
    );
    final updateJustCreatedDelta = ActionUpdateDelta(
      globalHiveApi.action.get('9012')!,
      name: 'My New Other Action',
    );
    final updateJustEditedDelta = ActionUpdateDelta(
      globalHiveApi.action.get('1234')!,
      name: 'My Final Action',
      instructions: 'Some instructions',
    );
    final deleteDelta = ActionDeleteDelta(deletableAction);

    await globalHiveApi.protectSyncBox((requests) {
      // We are now in a simulated sync.

      // Apply the deltas while the sync is happening.
      // Only update some fields, to check whether the incoming is properly
      // applied in the right order.
      addOneMoreDelta.apply();
      updateJustCreatedDelta.apply();
      updateJustEditedDelta.apply();
      deleteDelta.apply();

      // Simulate the end of the sync

      // First, we revert everything. This includes the deltas
      // applied *during* the sync.
      revertAll();
      // Test that we're back to having just the two original actions.
      expect(globalHiveApi.action.length, 2);
      expect(globalHiveApi.action.get('1234'), originalAction);
      expect(globalHiveApi.action.get('5678'), deletableAction);

      // The server accepted everything, but with some additions.
      // Someone else updated the same record.
      globalHiveApi.action.put(
        '9012',
        Action(id: '9012', name: 'My Other Action')..freeze(),
      );
      globalHiveApi.action.put(
        '1234',
        Action(
          id: '1234',
          name: 'My Updated Original Action',
          // Here is the server addition
          instructions: 'Some new instructions',
        )..freeze(),
      );
    });

    // Now, finally, apply the deltas again.
    addOneMoreDelta.apply();
    updateJustCreatedDelta.apply();
    updateJustEditedDelta.apply();
    deleteDelta.apply();

    // Check to see that everything is correct.
    expect(globalHiveApi.action.length, 3);
    expect(
      globalHiveApi.action.get('1234'),
      Action(
        id: '1234',
        name: 'My Final Action',
        instructions: 'Some new instructions',
      ),
    );
    expect(
      globalHiveApi.action.get('9012'),
      Action(
        id: '9012',
        name: 'My New Other Action',
      ),
    );
    expect(
      globalHiveApi.action.get('3456'),
      Action(
        id: '3456',
        name: 'My Newest Action',
      ),
    );

    expect(globalHiveApi.sync.length, 4);
    expect(
      globalHiveApi.sync.get('1234'),
      CreateUpdateActionsRequest(
        action: Action(
          id: '1234',
          name: 'My Final Action',
          instructions: 'Some new instructions',
        ),
        updateMask: FieldMask(paths: ['name']),
      ),
    );
    expect(
      globalHiveApi.sync.get('9012'),
      CreateUpdateActionsRequest(
        action: Action(
          id: '9012',
          name: 'My New Other Action',
        ),
        updateMask: FieldMask(paths: ['name']),
      ),
    );
    expect(
      globalHiveApi.sync.get('3456'),
      CreateUpdateActionsRequest(
        action: Action(
          id: '3456',
          name: 'My Newest Action',
        ),
      ),
    );
    expect(
      globalHiveApi.sync.get('5678'),
      DeleteActionRequest(
        actionId: '5678',
      ),
    );

    expect(globalHiveApi.revert.length, 1);
    final map = globalHiveApi.revert.get(4)!;
    expect(map.keys.length, 4);
    expect(
      map['1234'],
      Action(
        id: '1234',
        name: 'My Updated Original Action',
        instructions: 'Some new instructions',
      ),
    );
    expect(
      map['9012'],
      Action(id: '9012', name: 'My Other Action'),
    );
    expect(map.containsKey('3456'), true);
    expect(map['3456'], null);
    expect(map['5678'], deletableAction);
  });

  test('correctly handles delete deltas applied during sync', () async {
    final originalAction = Action(
      id: '1234',
      name: 'My Action',
    )..freeze();

    globalHiveApi.action.put('1234', originalAction);

    final deleteDelta = ActionDeleteDelta(originalAction);

    await globalHiveApi.protectSyncBox((requests) {
      // We are now in a simulated sync.

      deleteDelta.apply();

      // Simulate the end of the sync

      // First, we revert everything. This includes the deltas
      // applied *during* the sync.
      revertAll();
      // Test that we reverted correctly.
      expect(globalHiveApi.action.length, 1);
      expect(globalHiveApi.action.get('1234'), originalAction);

      // The server already deleted the record!
      globalHiveApi.action.delete('1234');
    });

    // Now apply the delta again.
    deleteDelta.apply();

    // Check to see that everything is correct.
    expect(globalHiveApi.action.length, 0);
    expect(globalHiveApi.sync.length, 0);
    expect(globalHiveApi.revert.length, 0);
  });

  test('correctly handles create/update deltas applied during sync that fails',
      () async {
    UserCreateDelta(id: '1234', name: 'My User')..apply();

    final createDelta = UserCreateDelta(
      id: '9012',
      name: 'My Other User',
    );
    final updateDelta = UserUpdateDelta(
      globalHiveApi.user.get('1234')!,
      name: 'My New User',
    );
    final createActionUserDelta =
        ActionUserCreateDelta(id: '5678', userId: '1234');

    try {
      await globalHiveApi.protectSyncBox((values) {
        // We are now in a simulated sync.

        createDelta.apply();
        updateDelta.apply();
        createActionUserDelta.apply();

        // Sync fails!
        throw Exception();
      });
    } catch (_) {
      expect(globalHiveApi.user.length, 2);
      expect(
        globalHiveApi.user.get('1234'),
        User(
          id: '1234',
          name: 'My New User',
          actions: [
            ActionUser(id: '5678', userId: '1234'),
          ],
        ),
      );
      expect(
        globalHiveApi.user.get('9012'),
        User(
          id: '9012',
          name: 'My Other User',
        ),
      );

      expect(globalHiveApi.revert.length, 1);
      final map = globalHiveApi.revert.get(16)!;
      expect(map.keys.length, 2);
      expect(map.keys.contains('1234'), true);
      expect(map['1234'], null);
      expect(map.keys.contains('9012'), true);
      expect(map['9012'], null);

      expect(globalHiveApi.sync.length, 3);
      expect(
        globalHiveApi.sync.get('1234'),
        CreateUpdateUserRequest(
          user: User(
            id: '1234',
            name: 'My New User',
          ),
        ),
      );
      expect(
        globalHiveApi.sync.get('5678'),
        CreateUpdateActionUserRequest(
          actionUser: ActionUser(id: '5678', userId: '1234'),
        ),
      );
      expect(
        globalHiveApi.sync.get('9012'),
        CreateUpdateUserRequest(
          user: User(
            id: '9012',
            name: 'My Other User',
          ),
        ),
      );
    }
  });

  test('correctly handles delete deltas applied during sync that fails',
      () async {
    ActionCreateDelta(id: '1234', name: 'My Action')..apply();

    try {
      await globalHiveApi.protectSyncBox((values) {
        // We are now in a simulated sync.

        ActionDeleteDelta(globalHiveApi.action.get('1234')!)..apply();

        // Sync fails!
        throw Exception();
      });
    } catch (_) {
      expect(globalHiveApi.action.length, 0);
      expect(globalHiveApi.sync.length, 0);
    }
  });
}
