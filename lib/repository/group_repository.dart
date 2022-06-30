import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/db/providers/group_provider.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/services/api_provider.dart';

class GroupRepository {
  final dbProvider = GroupProvider();
  // final apiProvider = ApiProvider();

  // Future<ResponseStream<Group>> getGroups() => apiProvider.getGroups();

  // Future<ResponseStream<EvaluationCategory>> getEvaluationCategories() =>
  //     apiProvider.getEvaluationCategories();

  Future<List<HiveGroup>> fetchGroupsFromDB() => dbProvider.getGroups();

  Future<void> addEditGroup(HiveGroup group) => dbProvider.addEditGroup(group);

  // Future<ResponseStream<CreateUpdateGroupsResponse>> createUpdateGroup(
  //         Stream<CreateUpdateGroupsRequest> request) =>
  //     apiProvider.createUpdateGroup(request);

  // Future<ResponseStream<CreateUpdateGroupUsersResponse>> createUpdateGroupUser(
  //         Stream<CreateUpdateGroupUsersRequest> request) =>
  //     apiProvider.createUpdateGroupUser(request);

  // Future<ResponseStream<DeleteGroupUsersResponse>> deleteGroupUsers(
  //         Stream<GroupUser> request) =>
  //     apiProvider.deleteGroupUsers(request);

  Future<void> createUpdateGroupUserInDB({
    required HiveGroupUser groupUser,
  }) =>
      dbProvider.createUpdateGroupUser(groupUser);
}
