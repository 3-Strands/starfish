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
    final created = revertBox.get(kCreatedKeys);
    expect(created is Map, true);
    expect(created.keys.length, 1);
    expect(created[12] is List, true);
    expect(created[12].length, 1);
    expect(created[12].first, '1234');

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
    final groupChanges = revertBox.get(12);
    expect(groupChanges is Map, true);
    expect(groupChanges.keys.length, 1);
    expect(groupChanges['1234'] is Group, true);
    expect(groupChanges['1234'].id, '1234');
    expect(groupChanges['1234'].name, 'My Group Name');
    expect(groupChanges['1234'].description.isEmpty, true);
    expect(groupChanges['1234'].linkEmail, 'old@domain.com');

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
    final actionChanges = revertBox.get(4);
    expect(actionChanges is Map, true);
    expect(actionChanges.keys.length, 1);
    expect(actionChanges['1234'] is Action, true);
    expect(actionChanges['1234'].id, '1234');
    expect(actionChanges['1234'].name, 'My Action Name');

    expect(syncBox.length, 1);
    final request = syncBox.values.first;
    expect(request is DeleteActionRequest, true);
    expect(request.actionId, '1234');
  });
}
