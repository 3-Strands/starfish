import 'dart:async';
import 'dart:collection';

import 'package:grpc/grpc.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/subjects.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/db/hive_country.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_keyed.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:starfish/db/hive_syncable.dart';
import 'package:starfish/src/generated/google/protobuf/field_mask.pb.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';
import 'package:starfish/utils/services/field_mask.dart';

enum HiveType {
  country,
  language,
  material,
  action,
  group,
}

class SyncRepository {
  SyncRepository({
    HiveApiInterface hiveApi = globalHiveApi,
    required this.client,
    required this.requestRefresh,
  }) {
    _managers = {
      HiveType.country: SyncManager(
        pull: (client) => client
            .listAllCountries(ListAllCountriesRequest())
            .map(HiveCountry.from)
            .populateBox(hiveApi.country),
      ),
      HiveType.language: SyncManager(
        pull: (client) => client
            .listLanguages(ListLanguagesRequest())
            .map(HiveLanguage.from)
            .populateBox(hiveApi.language),
      ),
      HiveType.material: LocalSyncManager(
        pull: (client) => client
            .listMaterials(ListMaterialsRequest())
            .forEach(HiveMaterial.populateBox),
        push: (client) => Future.value(),
      ),
      HiveType.action: LocalSyncManager(
        pull: (client) => client
            .listActions(ListActionsRequest())
            .forEach(HiveAction.populateBox),
        push: (client) => Future.value(),
      ),
      HiveType.group: LocalSyncManager(
        pull: (client) => client
            .listGroups(ListGroupsRequest())
            .forEach(HiveGroup.populateBox),
        push: (client) => Future.value(),
      ),
    };

    // TODO: watch to push
    // hiveApi.material.watch().listen((_) => _checkIfTableShouldBeSynced(HiveType.material));
    // hiveApi.action.watch().listen((_) => _checkIfTableShouldBeSynced(HiveType.action));
    // hiveApi.group.watch().listen((_) => _checkIfTableShouldBeSynced(HiveType.group));
  }

  void _checkIfTableShouldBeSynced(HiveType type) {
    final incoming = _skipNext[type];
    if (incoming != null && incoming > 0) {
      _skipNext[type] = incoming - 1;
      return;
    }
    _needsSync.add(type);
    _scheduleSync();
  }

  late Map<HiveType, SyncManager> _managers;
  final _isSyncing = BehaviorSubject<bool>.seeded(false);
  final _needsSync = <HiveType>{};
  Map<HiveType, int> _skipNext = {};

  StarfishClient client;
  final Future<StarfishClient> Function() requestRefresh;

  Stream<bool> get isSyncing => _isSyncing.stream;

  Future<void>? _pendingSync;
  void _scheduleSync() {
    _pendingSync ??=
        Future.delayed(const Duration(milliseconds: 500)).then((_) {
      _pendingSync = null;
      _initializeSync();
    });
  }

  void sync(Iterable<HiveType> items) {
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
      // This is to keep track of what needs to be pulled.
      final needsPullFromRemote = <HiveType>{};
      // We have to go in order, because some items
      // need to be synced before others.
      for (final hiveType in HiveType.values) {
        if (_needsSync.contains(hiveType)) {
          needsPullFromRemote.add(hiveType);
          _needsSync.remove(hiveType);
          final manager = _managers[hiveType];
          if (manager is LocalSyncManager) {
            await _makeRequestWithRefresh(manager.push);
          }
        }
      }
      // At this point, we've gone through in order all the items that
      // were previously marked as needing a sync. It's quite possible
      // some items were marked again as needing sync in that time. If
      // so, then those items should *not* be pulled here, since they
      // will be pulled on the next round.
      needsPullFromRemote.removeAll(_needsSync);
      await Future.wait(
        needsPullFromRemote.map(
            (hiveType) => _makeRequestWithRefresh(_managers[hiveType]!.pull)),
      );
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

class LocalSyncManager extends SyncManager {
  const LocalSyncManager({
    required Future<void> Function(StarfishClient client) pull,
    required this.push,
  }) : super(pull: pull);

  final Future<void> Function(StarfishClient client) push;
}

// class SingleBoxSyncManager<GrpcType, HiveType extends HiveKeyed> implements SyncManager {
//   SingleBoxSyncManager({
//     required this.box,
//     required this.initiateRemoteToLocalRequest,
//     required this.itemToHive,
//     required this.notifyIncoming,
//   });

//   final Box<HiveType> box;
//   final ResponseStream<GrpcType> Function(StarfishClient client) initiateRemoteToLocalRequest;
//   final HiveType Function(GrpcType grpcElement) itemToHive;
//   final void Function(int incoming) notifyIncoming;

//   Future<void> pull(StarfishClient client) async {
//     final items = await initiateRemoteToLocalRequest(client)
//         .map(itemToHive).toList();
//     notifyIncoming(items.length);
//     await populateDatabase(items);
//   }

//   Future<void> populateDatabase(List<HiveType> items) async {
//     await box.clear();
//     for (final item in items) {
//       box.put(item.key, item);
//     }
//   }
// }

extension GetElementsToSync<T extends HiveSyncable> on Box<T> {
  List<T> getElementsToSync() => values
      .where((item) => (item.isNew || item.isUpdated) && !item.isDirty)
      .toList();
}

extension PopulateBox<T extends HiveKeyed> on Stream<T> {
  Future<void> populateBox(Box<T> box) =>
      forEach((item) => box.put(item.key, item));
}
