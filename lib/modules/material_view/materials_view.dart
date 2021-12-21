import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/db/hive_material_topic.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/modules/material_view/add_edit_material_screen.dart';
import 'package:starfish/modules/material_view/report_material_dialog_box.dart';
import 'package:starfish/select_items/select_drop_down.dart';
import 'package:starfish/utils/helpers/general_functions.dart';
import 'package:starfish/widgets/custon_icon_button.dart';
import 'package:starfish/widgets/searchbar_widget.dart';
import 'package:starfish/widgets/task_status.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MaterialsScreen extends StatefulWidget {
  MaterialsScreen({Key? key, this.title = ''}) : super(key: key);

  final String title;

  @override
  _MaterialsScreenState createState() => _MaterialsScreenState();
}

class _MaterialsScreenState extends State<MaterialsScreen> {
  late List<HiveLanguage> _languageList;
  late List<HiveMaterialTopic> _topicList;

  late Box<HiveCurrentUser> _currentUserBox;

  late Box<HiveLanguage> _languageBox;
  late Box<HiveMaterialTopic> _topicBox;

  late HiveCurrentUser _user;

  late String _choiceText = AppLocalizations.of(context)!.noFilterApplied;

  final Key _focusDetectorKey = UniqueKey();
  late AppBloc bloc;
  @override
  void initState() {
    super.initState();
    _languageBox = Hive.box<HiveLanguage>(HiveDatabase.LANGUAGE_BOX);
    _topicBox = Hive.box<HiveMaterialTopic>(HiveDatabase.MATERIAL_TOPIC_BOX);
    _currentUserBox = Hive.box<HiveCurrentUser>(HiveDatabase.CURRENT_USER_BOX);

    _getAllLanguages();
    _getAllTopics();
    _getCurrentUser();
  }

  @override
  void didChangeDependencies() {
    bloc = Provider.of(context);
    super.didChangeDependencies();
  }

  void _getCurrentUser() {
    _user = _currentUserBox.values.first;
  }

  _fetchMaterialData(AppBloc bloc) async {
    bloc.materialBloc.fetchMaterialsFromDB();
  }

  void _getAllLanguages() {
    _languageList = _languageBox.values.toList();
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
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.70,
            child: SingleChildScrollView(
              child: _buildSlidingUpPanel(material),
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      key: _focusDetectorKey,
      onFocusGained: () {
        print('Gained focus');
        _fetchMaterialData(bloc);
      },
      onFocusLost: () {
        print('Lost focus');
        /*
        bloc.materialBloc.selectedLanguages.clear();
        _selectLanguage(bloc);
        bloc.materialBloc.selectedTopics.clear();
        */
      },
      child: Scaffold(
        backgroundColor: AppColors.materialSceenBG,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Scrollbar(
            thickness: 5.sp,
            isAlwaysShown: false,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 14.h),
                  _buildLanguagesContainer(bloc),
                  SizedBox(height: 10.h),
                  _buildTopicsContainer(bloc),
                  SizedBox(height: 10.h),
                  SearchBar(
                    initialValue: bloc.materialBloc.query,
                    onValueChanged: (value) {
                      setState(() {
                        bloc.materialBloc.setQuery(value);
                      });
                    },
                    onDone: (value) {
                      setState(() {
                        bloc.materialBloc.setQuery(value);
                      });
                    },
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    height: 60.h,
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
                          child: DropdownButton<String>(
                            isExpanded: true,
                            iconSize: 35,
                            style: TextStyle(
                              color: Color(0xFF434141),
                              fontSize: 16.sp,
                              fontFamily: 'OpenSans',
                            ),
                            hint: Text(
                              AppLocalizations.of(context)!
                                      .materialActionPrefix +
                                  _choiceText,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Color(0xFF434141),
                                fontSize: 16.sp,
                                fontFamily: 'OpenSans',
                              ),
                              textAlign: TextAlign.left,
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _choiceText = value!;
                              });
                            },
                            items: Strings.materialActionsList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    color: Color(0xFF434141),
                                    fontSize: 14.sp,
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
                  materialsList(bloc),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
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

  Widget materialsList(AppBloc bloc) {
    return StreamBuilder<List<HiveMaterial>>(
      stream: bloc.materialBloc.materials,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<HiveMaterial> _listToShow;

          if (bloc.materialBloc.query.isNotEmpty) {
            String _query = bloc.materialBloc.query;
            _listToShow = snapshot.data!
                .where((item) =>
                    item.title!.toLowerCase().contains(_query.toLowerCase()) ||
                    item.title!
                        .toLowerCase()
                        .startsWith(_query.toLowerCase()) ||
                    item.description!
                        .toLowerCase()
                        .contains(_query.toLowerCase()) ||
                    item.description!
                        .toLowerCase()
                        .startsWith(_query.toLowerCase()))
                .toList();
          } else {
            _listToShow = snapshot.data!;
          }
          return ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 10.0.w, right: 10.0.w),
              physics: NeverScrollableScrollPhysics(),
              itemCount: _listToShow.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return MaterialListItem(
                  material: _listToShow[index],
                  onMaterialTap: _onMaterialSelection,
                );
              });
        } else {
          return Container();
        }
      },
    );
  }

/*
  _selectLanguage(AppBloc bloc) {
    print('select language');
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
      child: SelectDropDown(
        navTitle: AppLocalizations.of(context)!.selectLanugages,
        placeholder: AppLocalizations.of(context)!.selectLanugages,
        selectedValues: bloc.materialBloc.selectedLanguages,
        dataSource: _languageList,
        type: SelectType.multiple,
        dataSourceType: DataSourceType.languages,
        onDoneClicked: <T>(languages) {
          setState(() {
            List<HiveLanguage> _selectedLanguages =
                List<HiveLanguage>.from(languages as List<dynamic>);
            bloc.materialBloc.selectedLanguages = _selectedLanguages;
            _fetchMaterialData(bloc);
          });
        },
      ),
    );
  }

  Container _buildTopicsContainer(AppBloc bloc) {
    return Container(
      margin: EdgeInsets.only(left: 15.w, right: 15.w),
      child: SelectDropDown(
        navTitle: AppLocalizations.of(context)!.selectTopics,
        placeholder: AppLocalizations.of(context)!.selectTopics,
        selectedValues: bloc.materialBloc.selectedTopics,
        dataSource: _topicList,
        enableSelectAllOption: true,
        type: SelectType.multiple,
        dataSourceType: DataSourceType.topics,
        onDoneClicked: <T>(topics) {
          setState(() {
            List<HiveMaterialTopic> _selectedTopics =
                List<HiveMaterialTopic>.from(topics as List<dynamic>);
            bloc.materialBloc.selectedTopics = _selectedTopics;
            _fetchMaterialData(bloc);
          });
        },
      ),
    );
  }

  Widget _buildLanguageList(HiveMaterial material) {
    List<Widget> languages = [];
    material.languageIds?.forEach((String languageId) {
      try {
        HiveLanguage _language =
            _languageList.firstWhere((element) => languageId == element.id);
        languages.add(Text(_language.name));
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
      topics.add(Text(topic));
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: topics,
    );
  }

  Widget _buildSlidingUpPanel(HiveMaterial material) {
    return Container(
      margin: EdgeInsets.only(left: 15.0.w, top: 40.h, right: 15.0.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 22.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 240.w,
                  child: Text(
                    '${AppLocalizations.of(context)!.materialTitlePrefix} ${material.title}',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: AppColors.txtFieldTextColor,
                      fontFamily: 'OpenSans',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Spacer(),
                CustomIconButton(
                  icon: Icon(
                    Icons.open_in_new,
                    color: Colors.blue,
                    size: 18.sp,
                  ),
                  text: AppLocalizations.of(context)!.open,
                  onButtonTap: () {
                    GeneralFunctions.openUrl(material.url!);
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          /*TaskStatus(
            height: 30.h,
            color: AppColors.completeTaskBGColor,
            label: 'complete',
            textStyle: TextStyle(
              fontSize: 14.sp,
              fontFamily: 'OpenSans',
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          TaskStatus(
            height: 30.h,
            color: AppColors.overdueTaskBGColor,
            label: 'overdueTaskBGColor',
          ),*/

          if (material.isAssignedToMe)
            TaskStatus(
              height: 30.h,
              color: getMyTaskStatusColor(material),
              label: getMyTaskLabel(context, material),
            ),
          SizedBox(
            height: 10.h,
          ),

          if (material.isAssignedToGroupWithLeaderRole)
            TaskStatus(
              height: 30.h,
              color: Color(0xFFCBE8FA),
              label: AppLocalizations.of(context)!.assignedToGroup,
            ),
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                AppLocalizations.of(context)!.lanugages,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color(0xFF3475F0),
                  fontFamily: 'OpenSans',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              CustomIconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.blue,
                  size: 18.sp,
                ),
                text: AppLocalizations.of(context)!.edit,
                onButtonTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEditMaterialScreen(
                        material: material,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          _buildLanguageList(material),
          SizedBox(
            height: 47.h,
          ),
          Text(
            AppLocalizations.of(context)!.topics,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Color(0xFF3475F0),
              fontFamily: 'OpenSans',
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          _buildTopicsList(material),
          SizedBox(
            height: 63.h,
          ),
          // TextButton(
          //   onPressed: () {
          //     showDialog(
          //       context: context,
          //       builder: (BuildContext context) {
          //         return ReportMaterialDialogBox(
          //           material: material,
          //         );
          //       },
          //     );
          //   },
          //   child:
          RichText(
            text: new TextSpan(
              children: [
                new TextSpan(
                  text: "If this material is inappropriate, ",
                  style: TextStyle(
                      color: Color(0xFFF65A4A),
                      fontSize: 16.sp,
                      fontStyle: FontStyle.italic),
                ),
                new TextSpan(
                  text: 'click here',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.solid,
                      color: Color(0xFFF65A4A),
                      fontSize: 16.sp,
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
                  text: ' to report it.',
                  style: new TextStyle(
                      color: Color(0xFFF65A4A),
                      fontSize: 16.sp,
                      fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),

          //   Text(
          //      AppLocalizations.of(context)!.reportInappropriateMaterial,
          //     style: TextStyle(
          //       color: Color(0xFFF65A4A),
          //       fontFamily: 'OpenSans',
          //       fontSize: 16.sp,
          //       fontStyle: FontStyle.italic,
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
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
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFFADADAD)),
              ),
              child: Text(AppLocalizations.of(context)!.close),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }
}

class MaterialListItem extends StatelessWidget {
  final HiveMaterial material;
  final Function(HiveMaterial material) onMaterialTap;

  MaterialListItem({required this.material, required this.onMaterialTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      color: AppColors.txtFieldBackground,
      child: InkWell(
        onTap: () {
          onMaterialTap(material);
        },
        child: Container(
          margin: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
          height: 99,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: 22.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 240.w,
                      child: Text(
                        '${AppLocalizations.of(context)!.materialTitlePrefix} ${material.title}',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: AppColors.txtFieldTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp),
                      ),
                    ),
                    Spacer(),
                    if (material.url != null && material.url!.isNotEmpty)
                      CustomIconButton(
                        icon: Icon(
                          Icons.open_in_new,
                          color: Colors.blue,
                          size: 18.sp,
                        ),
                        text: AppLocalizations.of(context)!.open,
                        onButtonTap: () {
                          GeneralFunctions.openUrl(material.url!);
                        },
                      ),
                  ],
                ),
              ),
              if (material.isAssignedToMe)
                TaskStatus(
                  height: 17.h,
                  color: getMyTaskStatusColor(material),
                  label: getMyTaskLabel(context, material),
                ),
              if (material.isAssignedToGroupWithLeaderRole)
                TaskStatus(
                  height: 17.h,
                  color: Color(0xFFCBE8FA),
                  label: AppLocalizations.of(context)!.assignedToGroup,
                ),
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
