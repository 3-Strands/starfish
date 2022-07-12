import 'dart:async';
import 'dart:collection';

import 'package:grpc/grpc.dart';
import 'package:hive/hive.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/db/hive_country.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:starfish/db/hive_syncable.dart';
import 'package:starfish/src/generated/google/protobuf/field_mask.pb.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';
import 'package:starfish/utils/services/field_mask.dart';

class SyncRepository {
  SyncRepository({
    required HiveApi hiveApi,
    required this.client,
    required this.requestRefresh,
  }) {
    countryManager = BoxManager<Country, HiveCountry>(
      box: hiveApi.country,
      initiateRemoteToLocalRequest: (client) =>
          client.listAllCountries(ListAllCountriesRequest()),
      itemToHive: HiveCountry.fromGrpcCountry,
    );

    languageManager = BoxManager<Language, HiveLanguage>(
      box: hiveApi.language,
      initiateRemoteToLocalRequest: (client) =>
          client.listLanguages(ListLanguagesRequest()),
      itemToHive: HiveLanguage.fromGrpcLanguage,
    );

    materialManager = BoxSyncManager<Material, HiveMaterial, CreateUpdateMaterialsRequest>(
      box: hiveApi.material,
      initiateLocalToRemoteRequest: (client, controller) =>
          client.createUpdateMaterials(controller.stream),
      itemToRequest: (material, {required bool isUpdated}) =>
          CreateUpdateMaterialsRequest(
            material: material,
            updateMask: isUpdated ? FieldMask(paths: kMaterialFieldMask) : null,
          ),
      initiateRemoteToLocalRequest: (client) =>
          client.listMaterials(ListMaterialsRequest()),
      itemToHive: HiveMaterial.from,
    );

    actionManager = BoxSyncManager<Action, HiveAction, CreateUpdateActionsRequest>(
      box: hiveApi.action,
      initiateLocalToRemoteRequest: (client, controller) =>
          client.createUpdateActions(controller.stream),
      itemToRequest: (action, {required bool isUpdated}) =>
          CreateUpdateActionsRequest(
            action: action,
            updateMask: isUpdated ? FieldMask(paths: kActionFieldMask) : null,
          ),
      initiateRemoteToLocalRequest: (client) =>
          client.listActions(ListActionsRequest()),
      itemToHive: HiveAction.from,
    );

    _syncState.stream.listen((isSyncing) {
      _isSyncing = isSyncing;
    });

    // hiveApi.action.watch().listen((event) {
    //   // Add actions to _needsSync
    //   add(const ScheduleSyncToRemote());
    // });
  }

  late BoxManager countryManager;
  late BoxManager languageManager;
  late BoxSyncManager materialManager;
  late BoxSyncManager actionManager;
  final _syncState = StreamController<bool>.broadcast();
  final _queue = Queue<List<BoxManager>>();

  StarfishClient client;
  final Future<StarfishClient> Function() requestRefresh;

  var _isSyncing = false;

  Stream<bool> get isSyncing => _syncState.stream;

  void queueSync(List<BoxManager> boxManagers) async {
    if (_isSyncing) {
      _queue.addLast(boxManagers);
      return;
    }
    _syncState.add(true);
    await _syncItems(boxManagers);
    while (_queue.isNotEmpty) {
      await _syncItems(_queue.removeFirst());
    }
    _syncState.add(false);
  }

  Future<void> _syncItems(List<BoxManager> boxManagers) async {
    for (final syncManager in List<BoxSyncManager>.from(
        boxManagers.where((manager) => manager is BoxSyncManager))) {
      await _makeRequestWithRefresh(syncManager.sendChangesToRemote);
    }
    await Future.wait(
      boxManagers.map((manager) => _makeRequestWithRefresh(manager.getChangesFromRemote)),
    );
  }

  Future<T> _makeRequestWithRefresh<T>(Future<T> Function(StarfishClient client) makeRequest) async {
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
    _syncState.close();
  }
}

class BoxManager<GrpcType, HiveType> {
  BoxManager({
    required this.box,
    required this.initiateRemoteToLocalRequest,
    required this.itemToHive,
  });

  final Box<HiveType> box;
  final ResponseStream<GrpcType> Function(StarfishClient client) initiateRemoteToLocalRequest;
  final HiveType Function(GrpcType grpcElement) itemToHive;

  Future<void> getChangesFromRemote(StarfishClient client) async {
    final items = await initiateRemoteToLocalRequest(client)
        .map(itemToHive).toList();
    await box.clear();
    box.addAll(items);
  }
}

class BoxSyncManager<GrpcType, HiveType extends HiveSyncable<GrpcType>, Request>
    extends BoxManager<GrpcType, HiveType>{
  BoxSyncManager({
    required Box<HiveType> box,
    required this.initiateLocalToRemoteRequest,
    required this.itemToRequest,
    required ResponseStream<GrpcType> Function(StarfishClient client) initiateRemoteToLocalRequest,
    required HiveType Function(GrpcType grpcElement) itemToHive,
  }) : super(
    box: box,
    initiateRemoteToLocalRequest: initiateRemoteToLocalRequest,
    itemToHive: itemToHive,
  );

  final ResponseStream Function(StarfishClient client, StreamController<Request> controller) initiateLocalToRemoteRequest;
  final Request Function(GrpcType grpcElement, {required bool isUpdated}) itemToRequest;

  Future<void> sendChangesToRemote(StarfishClient client) async {
    final elementsToSync = box.values.where((item) => (item.isNew || item.isUpdated) && !item.isDirty).toList();
    if (elementsToSync.isEmpty) {
      return;
    }
    final controller = StreamController<Request>();
    final responseStream = initiateLocalToRemoteRequest(client, controller);
    elementsToSync.forEach((item) {
      controller.add(itemToRequest(item.toGrpcCompatible(), isUpdated: item.isUpdated));
    });
    controller.close();
    // TODO: handle errors in response stream.
    await responseStream.drain();
  }
}
