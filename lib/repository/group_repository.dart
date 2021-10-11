import 'package:grpc/grpc.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/db/providers/group_provider.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/services/api_provider.dart';
import 'package:starfish/utils/services/field_mask.dart';

class GroupRepository {
  final dbProvider = GroupProvider();
  final apiProvider = ApiProvider();

  Future<ResponseStream<Group>> getGroups() => apiProvider.getGroups();

  Future<ResponseStream<EvaluationCategory>> getEvaluationCategories() =>
      apiProvider.getEvaluationCategories();

  Future<List<HiveGroup>> fetchGroupsFromDB() => dbProvider.getGroups();

  Future<void> addEditGroup(HiveGroup group) => dbProvider.addEditGroup(group);

  Future<ResponseStream<CreateUpdateGroupsResponse>> createUpdateGroup({
    required Group group,
    required List<String> fieldMaskPaths,
  }) =>
      apiProvider.createUpdateGroup(group, fieldMaskPaths);

  Future<ResponseStream<CreateUpdateGroupUsersResponse>> createUpdateGroupUser({
    required GroupUser groupUser,
    required List<String> fieldMaskPaths,
  }) =>
      apiProvider.createUpdateGroupUser(groupUser, kGroupUserFieldMask);

  Future<ResponseStream<DeleteGroupUsersResponse>> deleteGroupUsers(
          Stream<GroupUser> request) =>
      apiProvider.deleteGroupUsers(request);

  Future<int> deleteGroupUserFromDB(HiveGroupUser groupUser) =>
      dbProvider.deleteGroupUser(groupUser);
}
