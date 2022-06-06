// ignore: import_of_legacy_library_into_null_safe

import 'package:fbroadcast/fbroadcast.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/basic.dart' as widgetsBasic;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_file.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/db/hive_material_topic.dart';
import 'package:starfish/db/hive_user.dart';
import 'package:starfish/db/providers/current_user_provider.dart';
import 'package:starfish/db/providers/user_provider.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/enums/material_filter.dart';
import 'package:starfish/enums/material_visibility.dart';
import 'package:starfish/modules/material_view/add_edit_material_screen.dart';
import 'package:starfish/modules/settings_view/settings_view.dart';
import 'package:starfish/select_items/multi_select.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/modules/material_view/report_material_dialog_box.dart';
import 'package:starfish/utils/helpers/alerts.dart';
import 'package:starfish/utils/helpers/general_functions.dart';
import 'package:starfish/utils/services/sync_service.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:starfish/widgets/custon_icon_button.dart';
import 'package:starfish/widgets/last_sync_bottom_widget.dart';
import 'package:starfish/widgets/searchbar_widget.dart';
import 'package:starfish/widgets/task_status.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/wrappers/file_system.dart';
import 'package:starfish/wrappers/platform.dart';
import 'package:starfish/wrappers/window.dart';

class MaterialsScreen extends StatefulWidget {
  MaterialsScreen({Key? key, this.title = ''}) : super(key: key);

  final String title;

  @override
  _MaterialsScreenState createState() => _MaterialsScreenState();
}

class _MaterialsScreenState extends State<MaterialsScreen> {
  late List<HiveLanguage> _languageList;
  late List<HiveMaterialTopic> _topicList;

  late Box<HiveLanguage> _languageBox;
  late Box<HiveMaterialTopic> _topicBox;

  final Key _focusDetectorKey = UniqueKey();
  late AppBloc bloc;
  late ScrollController _scrollController;
  late AppLocalizations _appLocalizations;

  bool _viewDidDisappear = false;
  bool _isSelectingLanguage = false;

  bool _isFirstLoad = false;
  bool _isLoading = false;
  bool _hasMore = true;
  bool _isInitialized = false;

  List<HiveMaterial> _materials = [];

  @override
  void initState() {
    super.initState();
    _languageBox = Hive.box<HiveLanguage>(HiveDatabase.LANGUAGE_BOX);
    _topicBox = Hive.box<HiveMaterialTopic>(HiveDatabase.MATERIAL_TOPIC_BOX);

    _getAllLanguages();
    _getAllTopics();

    _scrollController = new ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        _loadMore();
      } else if (_scrollController.offset <=
              _scrollController.position.minScrollExtent &&
          !_scrollController.position.outOfRange) {}
    });
  }

  /*@override
  void didChangeDependencies() {
    bloc = Provider.of(context);
    _languageSelectDropDownController.selectedItems = bloc.materialBloc.selectedLanguages.toSet();
    _topicSelectDropDownController.selectedItems = bloc.materialBloc.selectedTopics.toSet();
    super.didChangeDependencies();
  }*/

  void _firstLoad() {
    setState(() {
      _isFirstLoad = true;
    });

    // Reset current paage
    bloc.materialBloc.currentPage = 0;

    List<HiveMaterial> fetchedList = bloc.materialBloc.fetchMaterialsFromDB();

    setState(() {
      _materials = fetchedList;
      _isFirstLoad = false;
      if (fetchedList.length > 0) {
        _hasMore = true;

        if (fetchedList.length <= bloc.materialBloc.itemsPerPage &&
            bloc.materialBloc.count <= bloc.materialBloc.itemsPerPage) {
          _hasMore = false;
          _isLoading = false;
        }
      }
    });
  }

  void _loadMore() {
    if (_hasMore == true && _isFirstLoad == false && _isLoading == false) {
      setState(() {
        _isLoading = true; // Display a progress indicator at the bottom
      });

      List<HiveMaterial> fetchedList = bloc.materialBloc.fetchMaterialsFromDB();

      if (fetchedList.length > 0) {
        setState(() {
          _hasMore = true;

          _materials.addAll(fetchedList);

          if (fetchedList.length <= bloc.materialBloc.itemsPerPage &&
              bloc.materialBloc.count <= bloc.materialBloc.itemsPerPage) {
            _hasMore = false;
            _isLoading = false;
          }
        });
      } else {
        setState(() {
          _hasMore = false;
        });
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  void _getAllLanguages() {
    _languageList = _languageBox.values.toList();
    _languageList.sort((a, b) => a.name.compareTo(b.name));
  }

  void _getAllTopics() {
    _topicList = _topicBox.values.toList();
  }

  void _onMaterialSelection(HiveMaterial material) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(34.r),
          topRight: Radius.circular(34.r),
        ),
      ),
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return widgetsBasic.StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(34.r)),
                color: Color(0xFFEFEFEF),
              ),
              child: _buildSlidingUpPanel(material));
        });
      },
    ).then((value) {
      setState(_firstLoad);
    });
  }

  bool hasLeaderRoleInGroupWhereCreater(String? creatorId) {
    if (creatorId == null) {
      return false;
    }
    HiveUser? _creator = UserProvider().getUserById(creatorId);
    if (_creator == null || _creator.groups == null) {
      return false;
    }
    // get Creator's grups
    bool _hasLeaderRole = false;

    List<HiveGroupUser> _currentUserGroupsWithLeaderRole = CurrentUserProvider()
        .getUserSync()
        .groups
        .where((groupUser) =>
            GroupUser_Role.valueOf(groupUser.role!) == GroupUser_Role.ADMIN ||
            GroupUser_Role.valueOf(groupUser.role!) == GroupUser_Role.TEACHER)
        .toList();

    if (_currentUserGroupsWithLeaderRole.length == 0) {
      return false;
    }

    _creator.groups!.forEach((element) {
      _hasLeaderRole = _currentUserGroupsWithLeaderRole.contains(element);
    });

    return _hasLeaderRole;
  }

  @override
  void dispose() {
    /*setState(() {
      _viewDidDisappear = true;
    });*/
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _appLocalizations = AppLocalizations.of(context)!;
    if (!_isInitialized) {
      bloc = Provider.of(context);
      _isInitialized = true;
    }

    return FocusDetector(
      key: _focusDetectorKey,
      onFocusGained: () {
        setState(() {
          _viewDidDisappear = false;
        });

        _getAllLanguages();
        if (!_isFirstLoad) {
          _firstLoad();
        }
      },
      onFocusLost: () {},
      child: Scaffold(
        backgroundColor: AppColors.materialSceenBG,
        appBar: AppBar(
          title: Container(
            height: 64.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AppLogo(hight: 36.h, width: 37.w),
                Text(
                  _appLocalizations.materialsTabItemText,
                  style: dashboardNavigationTitle,
                ),
                IconButton(
                  icon: SvgPicture.asset(AssetsPath.settings),
                  onPressed: () {
                    setState(
                      () {
                        Navigator.pushNamed(
                          context,
                          Routes.settings,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          backgroundColor: AppColors.materialSceenBG,
          elevation: 0.0,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Column(
            children: [
              Expanded(
                child: Scrollbar(
                  thickness: 5.w,
                  isAlwaysShown: false,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: 14.h),
                        (_viewDidDisappear && (_isSelectingLanguage == false))
                            ? Container()
                            : _buildLanguagesContainer(bloc),
                        SizedBox(height: 10.h),
                        _buildTopicsContainer(bloc),
                        SizedBox(height: 10.h),
                        SearchBar(
                          initialValue: bloc.materialBloc.query,
                          onValueChanged: (value) {
                            setState(() {
                              bloc.materialBloc.setQuery(value);
                              _firstLoad();
                            });
                          },
                          onDone: (value) {
                            setState(() {
                              bloc.materialBloc.setQuery(value);
                              _firstLoad();
                            });
                          },
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          height: 52.h,
                          // width: 345.w,
                          margin: EdgeInsets.only(left: 15.w, right: 15.w),
                          decoration: BoxDecoration(
                            color: AppColors.txtFieldBackground,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton<MaterialFilter>(
                                  isExpanded: true,
                                  iconSize: 35,
                                  style: TextStyle(
                                    color: Color(0xFF434141),
                                    fontSize: 19.sp,
                                    fontFamily: 'OpenSans',
                                  ),
                                  hint: Text(
                                    _appLocalizations.materialActionPrefix +
                                        '' +
                                        bloc.materialBloc.actionFilter.about,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Color(0xFF434141),
                                      fontSize: 19.sp,
                                      fontFamily: 'OpenSans',
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  onChanged: (MaterialFilter? value) {
                                    setState(() {
                                      bloc.materialBloc.actionFilter = value!;
                                      _firstLoad();
                                    });
                                  },
                                  items: MaterialFilter.values
                                      .map<DropdownMenuItem<MaterialFilter>>(
                                          (MaterialFilter value) {
                                    return DropdownMenuItem<MaterialFilter>(
                                      value: value,
                                      child: Text(
                                        value.about,
                                        style: TextStyle(
                                          color: Color(0xFF434141),
                                          fontSize: 17.sp,
                                          fontFamily: 'OpenSans',
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        _materialsList(bloc),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              LastSyncBottomWidget()
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.addNewMaterial).then(
                  (value) => FocusScope.of(context).requestFocus(
                    new FocusNode(),
                  ),
                );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _materialsList(AppBloc bloc) {
    if (_materials.isEmpty) {
      return Container(
        margin: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Text(
          '${_appLocalizations.noRecordFound}',
          style: TextStyle(
            color: Color(0xFF434141),
            fontSize: 17.sp,
            fontFamily: 'OpenSans',
          ),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(left: 10.0.w, right: 10.0.w),
      physics: NeverScrollableScrollPhysics(),
      itemCount: _hasMore ? _materials.length + 1 : _materials.length,
      itemBuilder: (BuildContext ctxt, int index) {
        if (index >= _materials.length) {
          return Container(
            margin: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                height: 24,
                width: 24,
              ),
            ),
          );
        }
        return MaterialListItem(
          material: _materials[index],
          onMaterialTap: _onMaterialSelection,
        );
      },
    );
  }

/*
  _selectLanguage(AppBloc bloc) {
    for (var languageId in _user.languageIds) {
      _languageList
          .where((item) => item.id == languageId)
          .forEach((item) => {bloc.materialBloc.selectedLanguages.add(item)});
    }
    _fetchMaterialData(bloc);
  }
*/

  Widget _buildLanguagesContainer(AppBloc bloc) {
    return Container(
      margin: EdgeInsets.only(left: 15.w, right: 15.w),
      child: MultiSelect<HiveLanguage>(
        navTitle: _appLocalizations.selectLanugages,
        placeholder: _appLocalizations.selectLanugages,
        items: _languageList,
        initialSelection: bloc.materialBloc.selectedLanguages.toSet(),
        toDisplay: HiveLanguage.toDisplay,
        onMoveNext: () {
          setState(() {
            _isSelectingLanguage = true;
          });
        },
        onFinished: (Set<HiveLanguage> selectedLanguages) {
          setState(() {
            _isSelectingLanguage = false;
            final _selectedLanguages = selectedLanguages.toList();
            bloc.materialBloc.checkAndUpdateUserfollowedLangguages(
                _selectedLanguages
                    .map((hiveLanguage) => hiveLanguage.id)
                    .toList());

            bloc.materialBloc.selectedLanguages = _selectedLanguages;
            _firstLoad();
          });
        },
      ),
    );
  }

  Container _buildTopicsContainer(AppBloc bloc) {
    return new Container(
      margin: EdgeInsets.only(left: 15.w, right: 15.w),
      child: MultiSelect<HiveMaterialTopic>(
        navTitle: _appLocalizations.selectTopics,
        placeholder: _appLocalizations.selectTopics,
        enableSelectAllOption: true,
        items: _topicList,
        initialSelection: bloc.materialBloc.selectedTopics.toSet(),
        toDisplay: HiveMaterialTopic.toDisplay,
        onFinished: (Set<HiveMaterialTopic> selectedTopics) {
          setState(() {
            bloc.materialBloc.selectedTopics =
                selectedTopics.toList();
            _firstLoad();
          });
        },
      ),
    );
  }

  Widget _buildLanguageList(HiveMaterial material) {
    List<Widget> languages = [];
    List<HiveLanguage> _languages = [];
    material.languages.forEach((key, value) {
      _languages.add(HiveLanguage(id: key, name: value));
    });
    _languages.sort((a, b) => a.name.compareTo(b.name));

    _languages.forEach((HiveLanguage _language) {
      try {
        languages.add(
          Text(
            _language.name,
            textAlign: TextAlign.left,
            style: TextStyle(
              //  color: Color(0xFF3475F0),
              fontFamily: 'OpenSans',
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      } on StateError catch (e) {
        debugPrint('EXCEPTION: ${e.message}');
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: languages,
    );
  }

  Widget _buildTopicsList(HiveMaterial material) {
    List<Widget> topics = [];

    material.topics?.forEach((String topic) {
      topics.add(
        Text(
          topic,
          textAlign: TextAlign.left,
          style: TextStyle(
            //   color: Color(0xFF3475F0),
            fontFamily: 'OpenSans',
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: topics,
    );
  }

  Widget _buildAttachment(HiveMaterial material) {
    List<Widget> attachments = [];

    material.localFiles.forEach((hiveFile) {
      attachments.add(
        widgetsBasic.Column(
          children: [
            InkWell(
              onTap: () {
                if (Platform.isAndroid) {
                  if (hiveFile.filepath != null) {
                    openFile(hiveFile.filepath!);
                  }
                } else if (Platform.isWeb) {
                  triggerDownload(hiveFile);
                }
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.file_present,
                    color: Color(0xFF3475F0),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    _appLocalizations.openAttachment + ": ",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xFF3475F0),
                      fontFamily: 'OpenSans',
                      // fontSize: 17.sp,
                      fontStyle: FontStyle.italic,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      hiveFile.filename,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xFF434141),
                        fontFamily: 'OpenSans',
                        //   fontSize: 17.sp,
                        fontStyle: FontStyle.italic,
                        //  fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Color(0xFF979797),
              thickness: 2,
            ),
          ],
        ),
      );
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: attachments,
    );
  }

  Widget _buildSlidingUpPanel(HiveMaterial material) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.white,
            margin: EdgeInsets.only(
              top: 40.h,
            ),
            child: Container(
              margin: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      //height: 22.h,

                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              '${_appLocalizations.materialTitlePrefix} ${material.title}',
                              //overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: AppColors.txtFieldTextColor,
                                fontFamily: 'OpenSans',
                                fontSize: 19.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (((Material_Editability.valueOf(
                                              material.editability!) ==
                                          Material_Editability.CREATOR_EDIT ||
                                      Material_Editability.valueOf(
                                              material.editability!) ==
                                          Material_Editability.GROUP_EDIT) &&
                                  material.creatorId ==
                                      CurrentUserProvider().user.id) ||
                              (Material_Editability.valueOf(
                                          material.editability!) ==
                                      Material_Editability.GROUP_EDIT) &&
                                  material.isAssignedToGroupWithLeaderRole)
                            PopupMenuButton(
                              icon: Icon(
                                Icons.more_vert,
                                color: Color(0xFF3475F0),
                                size: 30,
                              ),
                              color: Colors.white,
                              elevation: 20,
                              shape: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(12.r)),
                              enabled: true,
                              onSelected: (value) {
                                switch (value) {
                                  case 0:
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AddEditMaterialScreen(
                                          material: material,
                                        ),
                                      ),
                                    );

                                    break;
                                  case 1:
                                    _deleteMaterial(context, material);

                                    break;
                                }
                              },
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: Text(
                                    _appLocalizations.editMaterial,
                                    style: TextStyle(
                                        color: Color(0xFF3475F0),
                                        fontSize: 19.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  value: 0,
                                ),
                                PopupMenuItem(
                                  child: Text(
                                    '${_appLocalizations.delete} ${_appLocalizations.material}',
                                    style: TextStyle(
                                        color: Color(0xFF3475F0),
                                        fontSize: 19.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  value: 1,
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                    if (material.isAssignedToMe)
                      SizedBox(
                        height: 30.h,
                      ),
                    if (material.isAssignedToMe)
                      TaskStatus(
                        height: 30.h,
                        color: getMyTaskStatusColor(material),
                        label: getMyTaskLabel(context, material),
                      ),
                    if (material.isAssignedToGroupWithLeaderRole)
                      SizedBox(
                        height: 10.h,
                      ),
                    if (material.isAssignedToGroupWithLeaderRole)
                      TaskStatus(
                        height: 30.h,
                        color: Color(0xFFCBE8FA),
                        label: _appLocalizations.assignedToGroup,
                      ),
                    if (material.isAssignedToMe ||
                        material.isAssignedToGroupWithLeaderRole)
                      Divider(
                        color: Color(0xFF979797),
                        thickness: 2,
                      ),
                    SizedBox(
                      height: 30.h,
                    ),
                    if (material.url != null && material.url!.isNotEmpty)
                      CustomIconButton(
                        icon: Icon(
                          Icons.open_in_new,
                          color: Color(0xFF3475F0),
                          size: 21.5.sp,
                        ),
                        text: _appLocalizations.openExternalLink,
                        textStyle: TextStyle(
                          color: Color(0xFF3475F0),
                          fontFamily: 'OpenSans',
                          // fontSize: 17.sp,
                          fontStyle: FontStyle.italic,
                          // fontWeight: FontWeight.bold,
                        ),
                        onButtonTap: () {
                          GeneralFunctions.openUrl(material.url!);
                        },
                      ),
                    if (material.url != null && material.url!.isNotEmpty)
                      Divider(
                        color: Color(0xFF979797),
                        thickness: 2,
                      ),
                    if (material.localFiles.length != 0 &&
                        material.localFiles.isNotEmpty)
                      _buildAttachment(material),
                    SizedBox(
                      height: 30.h,
                    ),
                    if (((Material_Editability.valueOf(material.editability!) ==
                                    Material_Editability.CREATOR_EDIT ||
                                Material_Editability.valueOf(
                                        material.editability!) ==
                                    Material_Editability.GROUP_EDIT) &&
                            material.creatorId ==
                                CurrentUserProvider().user.id) ||
                        (Material_Editability.valueOf(material.editability!) ==
                                Material_Editability.GROUP_EDIT) &&
                            material.isAssignedToGroupWithLeaderRole) ...[
                      Text(
                        _appLocalizations.thismaterialIsVisibleTo,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color(0xFF3475F0),
                          fontFamily: 'OpenSans',
                          fontSize: 19.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.remove_red_eye,
                            color: Color(0xFF3475F0),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            MaterialVisibility.valueOf(material.visibility!)
                                .displayName!,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              //   color: Color(0xFF3475F0),
                              fontFamily: 'OpenSans',
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Color(0xFF979797),
                        thickness: 2,
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                    ],
                    Text(
                      _appLocalizations.lanugages,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xFF3475F0),
                        fontFamily: 'OpenSans',
                        fontSize: 19.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (material.languageIds!.isNotEmpty)
                      SizedBox(
                        height: 5.h,
                      ),
                    _buildLanguageList(material),
                    Divider(
                      color: Color(0xFF979797),
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      _appLocalizations.topics,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xFF3475F0),
                        fontFamily: 'OpenSans',
                        fontSize: 19.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (material.topics!.isNotEmpty)
                      SizedBox(
                        height: 5.h,
                      ),
                    _buildTopicsList(material),
                    SizedBox(
                      height: 63.h,
                    ),
                    RichText(
                      text: new TextSpan(
                        children: [
                          new TextSpan(
                            text: _appLocalizations.inAppropriateMaterial,
                            style: TextStyle(
                                color: Color(0xFFF65A4A),
                                fontSize: 19.sp,
                                fontStyle: FontStyle.italic),
                          ),
                          new TextSpan(
                            text: _appLocalizations.clickHere,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.solid,
                                color: Color(0xFFF65A4A),
                                fontSize: 19.sp,
                                fontStyle: FontStyle.italic),
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ReportMaterialDialogBox(
                                      material: material,
                                    );
                                  },
                                );
                              },
                          ),
                          new TextSpan(
                            text: _appLocalizations.toReportIt,
                            style: new TextStyle(
                                color: Color(0xFFF65A4A),
                                fontSize: 19.sp,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 75.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color(0xFFEFEFEF),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 30.0, right: 30.0, top: 19.0, bottom: 19.0),
            child: Container(
              height: 37.5.h,
              color: Color(0xFFEFEFEF),
              child: ElevatedButton(
                onPressed: () {
                  //_closeSlidingUpPanelIfOpen();
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.r),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      AppColors.selectedButtonBG),
                ),
                child: Text(_appLocalizations.close),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _deleteMaterial(BuildContext context, HiveMaterial material) {
    Alerts.showMessageBox(
        context: context,
        title: _appLocalizations.deleteMaterialTitle,
        message: _appLocalizations.areYouSureWantToDeleteThis,
        positiveButtonText: _appLocalizations.delete,
        negativeButtonText: _appLocalizations.cancel,
        positiveActionCallback: () {
          // Mark this material for deletion
          material.isDirty = true;
          bloc.materialBloc.createUpdateMaterial(material);

          // Broadcast to sync the delete Material with the server
          FBroadcast.instance().broadcast(
            SyncService.kDeleteMaterial,
          );
          Navigator.of(context).pop();
          // TODO: delete asociated files(if any) for deletion
        },
        negativeActionCallback: () {
          // donothing
        });
  }
}

class MaterialListItem extends StatelessWidget {
  final HiveMaterial material;
  final Function(HiveMaterial material) onMaterialTap;

  MaterialListItem({required this.material, required this.onMaterialTap});

  @override
  Widget build(BuildContext context) {
    AppLocalizations _appLocalizations = AppLocalizations.of(context)!;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.r),
        ),
      ),
      color: AppColors.txtFieldBackground,
      child: InkWell(
        onTap: () {
          onMaterialTap(material);
        },
        child: Container(
          margin: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
          padding: EdgeInsets.symmetric(vertical: 8.h),
          /*height: (material.isAssignedToGroupWithLeaderRole &&
                  material.isAssignedToMe)
              ? 110
              : (material.isAssignedToMe)
                  ? 85
                  : 65,*/
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: 10.h,
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      //width: 240.w,
                      child: Text(
                        '${_appLocalizations.materialTitlePrefix} ${material.title}',
                        //overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: AppColors.txtFieldTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.sp),
                      ),
                    ),
                    //Spacer(),
                    if (material.url != null && material.url!.isNotEmpty)
                      CustomIconButton(
                        icon: Icon(
                          Icons.open_in_new,
                          color: Colors.blue,
                          size: 21.5.sp,
                        ),
                        text: _appLocalizations.open,
                        onButtonTap: () {
                          GeneralFunctions.openUrl(material.url!);
                        },
                      ),
                  ],
                ),
              ),
              if (material.isAssignedToMe ||
                  material.isAssignedToGroupWithLeaderRole) ...[
                SizedBox(
                  height: 16.h,
                ),
                if (material.isAssignedToMe) ...[
                  TaskStatus(
                    height: 17.h,
                    color: getMyTaskStatusColor(material),
                    label: getMyTaskLabel(context, material),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
                if (material.isAssignedToGroupWithLeaderRole)
                  TaskStatus(
                    height: 17.h,
                    color: Color(0xFFCBE8FA),
                    label: _appLocalizations.assignedToGroup,
                  ),
              ],
              SizedBox(
                height: 10.h,
              ),
              material.localFiles.length > 0
                  ? Text(
                      Intl.plural(material.localFiles.length,
                          zero:
                              "${material.localFiles.length} ${_appLocalizations.attachment}",
                          one: "${material.localFiles.length} ${_appLocalizations.attachment}",
                          other: "${material.localFiles.length} ${_appLocalizations.attachments}",
                          args: [material.localFiles.length]),
                      style: TextStyle(
                          color: Color(0xFF3475F0),
                          fontFamily: 'OpenSans',
                          fontSize: 19.sp,
                          fontStyle: FontStyle.italic),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
      elevation: 5,
    );
  }
}

Color getMyTaskStatusColor(HiveMaterial material) {
  if (material.myActionStatus == ActionStatus.DONE) {
    return AppColors.completeTaskBGColor;
  } else if (material.myActionStatus == ActionStatus.NOT_DONE) {
    return AppColors.notCompletedTaskBGColor;
  } else if (material.myActionStatus == ActionStatus.OVERDUE) {
    return AppColors.overdueTaskBGColor;
  } else {
    return Colors.transparent;
  }
}

String getMyTaskLabel(BuildContext context, HiveMaterial material) {
  if (material.myActionStatus == ActionStatus.DONE) {
    return AppLocalizations.of(context)!.assignedToMeDone;
  } else if (material.myActionStatus == ActionStatus.NOT_DONE) {
    return AppLocalizations.of(context)!.assignedToMeNotDone;
  } else if (material.myActionStatus == ActionStatus.OVERDUE) {
    return AppLocalizations.of(context)!.assignedToMeOverdue;
  } else {
    return '';
  }
}
