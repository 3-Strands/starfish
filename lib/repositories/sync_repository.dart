import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:rxdart/subjects.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';

enum ModelType {
  country,
  language,
  material,
  action,
  group,
  user,
}

class SyncRepository {
  SyncRepository({
    HiveApiInterface hiveApi = globalHiveApi,
    required this.client,
    required this.requestRefresh,
  }) {
    _managers = {
      ModelType.country: SyncManager(
        pull: (client) => client
            .listAllCountries(ListAllCountriesRequest())
            .forEach((country) => hiveApi.country.put(country.id, country)),
      ),
      ModelType.language: SyncManager(
        pull: (client) => client
            .listLanguages(ListLanguagesRequest())
            .forEach((language) => hiveApi.language.put(language.id, language)),
      ),
      ModelType.material: SyncManager(
        pull: (client) => client
            .listMaterials(ListMaterialsRequest())
            .forEach((material) => hiveApi.material.put(material.id, material)),
      ),
      ModelType.action: SyncManager(
        pull: (client) => client
            .listActions(ListActionsRequest())
            .forEach((action) => hiveApi.action.put(action.id, action)),
      ),
      ModelType.group: SyncManager(
        pull: (client) => client
            .listGroups(ListGroupsRequest())
            .forEach((group) => hiveApi.group.put(group.id, group)),
      ),
      ModelType.user: SyncManager(
        pull: (client) => client
            .listUsers(ListUsersRequest())
            .forEach((user) => hiveApi.user.put(user.id, user)),
      ),
    };

    // TODO: watch to push
    // hiveApi.material.watch().listen((_) => _checkIfTableShouldBeSynced(modelType.material));
    // hiveApi.action.watch().listen((_) => _checkIfTableShouldBeSynced(modelType.action));
    // hiveApi.group.watch().listen((_) => _checkIfTableShouldBeSynced(modelType.group));
  }

  void _checkIfTableShouldBeSynced(ModelType type) {
    final incoming = _skipNext[type];
    if (incoming != null && incoming > 0) {
      _skipNext[type] = incoming - 1;
      return;
    }
    _needsSync.add(type);
    _scheduleSync();
  }

  late Map<ModelType, SyncManager> _managers;
  final _isSyncing = BehaviorSubject<bool>.seeded(false);
  final _needsSync = <ModelType>{};
  Map<ModelType, int> _skipNext = {};

  StarfishClient client;
  final Future<StarfishClient> Function() requestRefresh;

  Stream<bool> get isSyncing => _isSyncing.stream;

  Future<void>? _pendingSync;
  void _scheduleSync() {
    _pendingSync ??= Future.delayed(const Duration(milliseconds: 500), () {
      _pendingSync = null;
      _initializeSync();
    });
  }

  void sync(Iterable<ModelType> items) {
    _needsSync.addAll(items);
    _initializeSync();
  }

  void _initializeSync() async {
    if (_isSyncing.value) {
      return;
    }
    _isSyncing.add(true);
    // We will keep going until this is drained.
    while (_needsSync.isNotEmpty) {
      final needsSync = {..._needsSync};
      _needsSync.clear();
      await Future.wait(
        needsSync.map(
            (modelType) => _makeRequestWithRefresh(_managers[modelType]!.pull)),
      );
      // // This is to keep track of what needs to be pulled.
      // final needsPullFromRemote = <ModelType>{};
      // // We have to go in order, because some items
      // // need to be synced before others.
      // for (final modelType in ModelType.values) {
      //   if (_needsSync.contains(modelType)) {
      //     needsPullFromRemote.add(modelType);
      //     _needsSync.remove(modelType);
      //     final manager = _managers[modelType];
      //     if (manager is SyncManager) {
      //       await _makeRequestWithRefresh(manager.push);
      //     }
      //   }
      // }
      // // At this point, we've gone through in order all the items that
      // // were previously marked as needing a sync. It's quite possible
      // // some items were marked again as needing sync in that time. If
      // // so, then those items should *not* be pulled here, since they
      // // will be pulled on the next round.
      // needsPullFromRemote.removeAll(_needsSync);
      // await Future.wait(
      //   needsPullFromRemote.map(
      //       (modelType) => _makeRequestWithRefresh(_managers[modelType]!.pull)),
      // );
    }
    _isSyncing.add(false);
  }

  Future<T> _makeRequestWithRefresh<T>(
      Future<T> Function(StarfishClient client) makeRequest) async {
    try {
      return await makeRequest(client);
    } on GrpcError catch (error) {
      if (error.code == StatusCode.unauthenticated) {
        client = await requestRefresh();
        return await makeRequest(client);
      } else {
        throw error;
      }
    }
  }

  void close() {
    _isSyncing.close();
  }
}

class SyncManager {
  const SyncManager({
    required this.pull,
  });

  final Future<void> Function(StarfishClient client) pull;
}
