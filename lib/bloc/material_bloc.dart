import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:fbroadcast/fbroadcast.dart';
import 'package:rxdart/rxdart.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:starfish/db/hive_file.dart';
import 'package:starfish/db/hive_material_topic.dart';
import 'package:starfish/db/providers/action_provider.dart';
import 'package:starfish/db/providers/current_user_provider.dart';
import 'package:starfish/db/providers/material_provider.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/enums/material_filter.dart';
import 'package:starfish/repository/materials_repository.dart';
import 'package:starfish/src/generated/file_transfer.pb.dart';
import 'package:starfish/src/generated/file_transfer.pbgrpc.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/services/sync_service.dart';

class MaterialBloc extends Object {
  MaterialRepository materialRepository = MaterialRepository();
  List<HiveLanguage> selectedLanguages = [];
  List<HiveMaterialTopic> selectedTopics = [];
  String query = '';
  MaterialFilter actionFilter = MaterialFilter.NO_FILTER_APPLIED;

  late BehaviorSubject<List<HiveMaterial>> _materials;
  late BehaviorSubject<FileData> _fileData;

  int count = 0;

  MaterialBloc() {
    _materials = new BehaviorSubject<List<HiveMaterial>>();
    _fileData = new BehaviorSubject<FileData>();

    _fileData.stream.listen((event) {
      if (event.hasChunk()) {
        return;
      }
    });

    _allMaterials = MaterialProvider().getMateialsSync();
    count = _allMaterials.length;
  }

  // Add data to Stream
  Stream<List<HiveMaterial>> get materials => _materials.stream;
  Stream<FileData> get fileData => _fileData.stream;

  List<File> _selectedFiles = [];
  List<HiveMaterial> _allMaterials = [];
  List<HiveMaterial> _filteredMaterialsList = [];

  final itemsPerPage = 20;
  int currentPage = 0;

  setActionFilter(MaterialFilter filter) {
    actionFilter = filter;
  }

  setQuery(String qury) {
    query = qury;
  }

  List<HiveMaterial> fetchMaterialsFromDB() {
    _allMaterials = MaterialProvider()
        .getMateialsSync()
        .where((element) => !element.isDirty)
        .toList();
    /*materialRepository
        .fetchMaterialsFromDB()
        .then(
          (value) => {_allMaterials = value},
        )
        .whenComplete(
          () => {
            _filteredMaterialsList = _filterMaterials(),
            _materials.sink.add(_filteredMaterialsList)
          },
        );*/
    List<HiveMaterial> list = [];
    List<HiveMaterial> _filteredList = [];
    if (_isFiltersSet()) {
      _filteredList = _filterMaterials(_allMaterials);
    } else {
      _filteredList = _allMaterials;
    }
    count = _filteredList.length;
    int n = min(itemsPerPage, count - (currentPage * itemsPerPage));
    if (n < 0) {
      return list;
    }
    list = _filteredList.skip(currentPage * itemsPerPage).take(n).toList();
    currentPage++;
    return list;
  }

  bool _isFiltersSet() {
    return selectedLanguages.length > 0 ||
        selectedTopics.length > 0 ||
        actionFilter != MaterialFilter.NO_FILTER_APPLIED ||
        query.isNotEmpty;
  }

  bool _ifMaterialSupportsLanguage(
      HiveMaterial _material, List<HiveLanguage> _selectedLanguages) {
    // if (_selectedLanguages.length == 0) {
    //   return true;
    // }
    if (_selectedLanguages.length == 0 ||
        _material.languageIds == null ||
        _material.languageIds!.length == 0) {
      return false;
    }

    Set<String> _selectdLanguageSet =
        _selectedLanguages.map((e) => e.id).toList().toSet();

    Set<String> _materialLanguageSet = _material.languageIds!.toSet();

    return _materialLanguageSet.intersection(_selectdLanguageSet).length > 0;
  }

  bool _ifMaterialSupportsTopic(
      HiveMaterial _material, List<HiveMaterialTopic> _selectedTopics) {
    if (_selectedTopics.length == 0) {
      return true;
    }
    if (_material.topics == null || _material.topics!.length == 0) {
      return false;
    }

    Set<String> _selectdTopicsSet =
        _selectedTopics.map((e) => e.name).toList().toSet();

    Set<String> _materialTopicsSet = _material.topics!.toSet();

    return _materialTopicsSet.intersection(_selectdTopicsSet).length > 0;
  }

  bool _applyMaterialFilter(HiveMaterial _material) {
    /*
    ASSIGNED_AND_COMPLETED,
    ASSIGNED_AND_INCOMPLETED,
    ASSIGNED_TO_GROUP_I_LEAD,
    NO_FILTER_APPLIED
    */

    switch (actionFilter) {
      case MaterialFilter.ASSIGNED_AND_COMPLETED:
        if (_material.isAssignedToMe &&
            _material.myActionStatus == ActionStatus.DONE) {
          return true;
        } else {
          return false;
        }
      case MaterialFilter.ASSIGNED_AND_INCOMPLETED:
        if (_material.isAssignedToMe &&
            _material.myActionStatus == ActionStatus.NOT_DONE) {
          return true;
        } else {
          return false;
        }
      case MaterialFilter.ASSIGNED_TO_GROUP_I_LEAD:
        if (_material.isAssignedToGroupWithLeaderRole) {
          return true;
        } else {
          return false;
        }
      default:
        return true;
    }
  }

  List<HiveMaterial> _filterMaterials(List<HiveMaterial> materials) {
    List<HiveMaterial> _results = [];
    materials.forEach((element) {
      if (_ifMaterialSupportsLanguage(element, selectedLanguages) &&
          _ifMaterialSupportsTopic(element, selectedTopics) &&
          _applyMaterialFilter(element) &&
          containsQueryString(element)) {
        _results.add(element);
      }
    });
    return _results;
  }

  bool containsQueryString(HiveMaterial material) {
    if (query.isEmpty) {
      return true;
    }
    return material.title!.toLowerCase().contains(query.toLowerCase()) ||
        material.title!.toLowerCase().startsWith(query.toLowerCase()) ||
        material.description!.toLowerCase().contains(query.toLowerCase()) ||
        material.description!.toLowerCase().startsWith(query.toLowerCase());
  }

  Future<void> createUpdateMaterial(HiveMaterial material,
      {List<HiveFile>? files}) async {
    return materialRepository
        .createUpdateMaterialInDB(material, files: files)
        .then((_) {
      _changeActionTypeIfHasMaterial(material);
      fetchMaterialsFromDB();
    });
  }

  _changeActionTypeIfHasMaterial(HiveMaterial hiveMaterial) {
    ActionProvider()
      .getAllActiveActions()
      .where(
        (HiveAction hiveAction) => hiveAction.materialId == hiveMaterial.id)
        .forEach((HiveAction action) {
          // As action type is output only value, so changing the action type is totally
          // depends on value associated with respected action type, i.e. quesion and materialId

          action.materialId = "";
          action.question = "";
          action.type = Action_Type.TEXT_INSTRUCTION.value;
          action.isUpdated = true;
        });
  }

  @Deprecated('upload is to be done using syncService')
  uploadMaterial(String entityId, File file) async {
/*    final Map<String, String>? metadata = {
      'authorization': await StarfishSharedPreference().getAccessToken(),
      'x-api-key': 'AIzaSyCRxikcHzD0PrDAqG797MQyctEwBSIf5t0'
    };

    final channel = GrpcOrGrpcWebClientChannel.toSingleEndpoint(
        host: "sandbox-api.everylanguage.app",
        port: 443,
        transportSecure: true);

    FileTransferClient? client = FileTransferClient(
      channel,
      options: CallOptions(metadata: metadata),
    );
*/
    /*StreamController<FileData> _controller = 
        StreamController<FileData>.broadcast();*/

    FileMetaData metaData = FileMetaData(
      entityId: entityId,
      filename: file.path.split("/").last,
      entityType: EntityType.MATERIAL,
    );
    FileData fileMetaData = FileData(metaData: metaData);

    /*ResponseStream<UploadStatus> responseStream =
        client.upload(_controller.stream);*/

    /*   materialRepository.apiProvider.uploadFile(fileData).then((responseStream) {
      responseStream.listen((value) {
        print("File UploadStatus: $value");
      });
    });*/

    /*responseStream.listen((value) {
      print("File UploadStatus: $value");
    });*/

    _fileData.sink.add(fileMetaData);

    /*Stream<List<int>> inputStream = file.openRead();
    inputStream.listen((event) {
      _controller.sink.add(FileData(chunk: event));
    }, onDone: () {
      print("DONE");
      _controller.sink.add(fileMetaData);
      _controller.close();
    }, onError: (error) {
      print("ERROR: $error");
    });*/

    final semicolon = ';'.codeUnitAt(0);
    RandomAccessFile randomAccessFile = file.openSync(mode: FileMode.read);
    //final result = <int>[];
    while (true) {
      final byte = await randomAccessFile.readByte();
      //result.add(byte);
      _fileData.sink.add(FileData(chunk: [byte].toList()));
      if (byte == semicolon) {
        //print(String.fromCharCodes(result));
        _fileData.sink.add(fileMetaData);
        //_controller.sink.done;
        //_controller.close();
        await randomAccessFile.close();
        break;
      }
    }
  }

  _handleUploadError(Object? error, StackTrace stackTrace) {
    print("UploadStatus[onError]: $error");
  }

  void setSelectedFiles(List<File> selectedFiles) {
    _selectedFiles = selectedFiles;
  }

  void checkAndUpdateUserfollowedLangguages(List<String>? languageIds) {
    // update the material language(s) as user language(s), if not already
    List<String>? _newLanguages = languageIds
        ?.where((element) =>
            !CurrentUserProvider().getUserSync().languageIds.contains(element))
        .toList();

    if (_newLanguages != null && _newLanguages.length > 0) {
      HiveCurrentUser _hiveCurrentUser = CurrentUserProvider().getUserSync();
      _hiveCurrentUser.languageIds.addAll(_newLanguages);
      _hiveCurrentUser.isUpdated = true;

      _hiveCurrentUser.save().then((value) {
        // Broadcast to sync the local changes with the server
        FBroadcast.instance().broadcast(
          SyncService.kUpdateCurrentUser,
          value: _hiveCurrentUser,
        );
      });
    }
  }

  void dispose() {
    _materials.close();
    _fileData.close();
  }
}
