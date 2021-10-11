import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/db/hive_material_topic.dart';
import 'package:starfish/modules/material_view/add_edit_material_screen.dart';
import 'package:starfish/modules/material_view/report_material_dialog_box.dart';
import 'package:starfish/select_items/select_drop_down.dart';
import 'package:starfish/utils/helpers/general_functions.dart';
import 'package:starfish/widgets/custon_icon_button.dart';
import 'package:starfish/widgets/searchbar_widget.dart';
import 'package:starfish/widgets/task_status.dart';

class MaterialsScreen extends StatefulWidget {
  MaterialsScreen({Key? key, this.title = ''}) : super(key: key);

  final String title;

  @override
  _MaterialsScreenState createState() => _MaterialsScreenState();
}

class _MaterialsScreenState extends State<MaterialsScreen> {
  late List<HiveLanguage> _languageList;
  late List<HiveMaterialTopic> _topicsList;

  late Box<HiveLanguage> _languageBox;
  late Box<HiveMaterialTopic> _materialTopicBox;
  late String _choiceText = 'No filter applied';

  @override
  void initState() {
    super.initState();
    _languageBox = Hive.box<HiveLanguage>(HiveDatabase.LANGUAGE_BOX);
    _materialTopicBox =
        Hive.box<HiveMaterialTopic>(HiveDatabase.MATERIAL_TOPIC_BOX);

    _getAllLanguages();
    _getAllTopics();
  }

  _fetchMaterialData(AppBloc bloc) async {
    bloc.materialBloc.fetchMaterialsFromDB();
  }

  void _getAllLanguages() {
    _languageList = _languageBox.values.toList();
  }

  void _getAllTopics() {
    _topicsList = _materialTopicBox.values.toList();
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
        return StatefulBuilder(builder: (BuildContext context,
            StateSetter setState /*You can rename this!*/) {
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
    final bloc = Provider.of(context);

    return Scaffold(
      backgroundColor: AppColors.materialSceenBG,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
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
                          'Action: ' + _choiceText,
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
                        items: <String>[
                          'Assigned to me and completed',
                          'Assigned to me but incomplete',
                          'Assigned to a group I lead',
                          'No filter applied',
                        ].map<DropdownMenuItem<String>>((String value) {
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

  Widget _buildLanguagesContainer(AppBloc bloc) {
    bloc.materialBloc.selectedLanguages = _languageList;
    _fetchMaterialData(bloc);

    return Container(
      margin: EdgeInsets.only(left: 15.w, right: 15.w),
      child: SelectDropDown(
        navTitle: Strings.selectLanugages,
        placeholder: Strings.selectLanugages,
        selectedValues: bloc.materialBloc.selectedLanguages,
        choice: SelectType.multiple,
        dataSource: DataSourceType.languages,
        onDoneClicked: <T>(languages) {
          setState(() {
            List<HiveLanguage> _selectedLanguages =
                languages as List<HiveLanguage>;
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
        navTitle: Strings.selectTopics,
        placeholder: Strings.selectTopics,
        selectedValues: bloc.materialBloc.selectedTopics,
        choice: SelectType.multiple,
        dataSource: DataSourceType.topics,
        onDoneClicked: <T>(topics) {
          setState(() {
            List<HiveMaterialTopic> _selectedTopics =
                topics as List<HiveMaterialTopic>;
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
        print('EXCEPTION: ${e.message}');
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
                    'Title: ${material.title}',
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
                  text: Strings.open,
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
          TaskStatus(
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
          ),
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                Strings.lanugages,
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
                text: Strings.edit,
                onButtonTap: () {
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
            Strings.topics,
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
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ReportMaterialDialogBox(
                    material: material,
                  );
                },
              );
            },
            child: Text(
              Strings.reportInappropriateMaterial,
              style: TextStyle(
                color: Color(0xFFF65A4A),
                fontFamily: 'OpenSans',
                fontSize: 16.sp,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
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
              child: Text(Strings.close),
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
                // margin: EdgeInsets.only(left: 25.0.w, right: 25.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 240.w,
                      child: Text(
                        'Title: ${material.title}',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: AppColors.txtFieldTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp),
                      ),
                    ),
                    Spacer(),
                    CustomIconButton(
                      icon: Icon(
                        Icons.open_in_new,
                        color: Colors.blue,
                        size: 18.sp,
                      ),
                      text: Strings.open,
                      onButtonTap: () {
                        GeneralFunctions.openUrl(material.url!);
                      },
                    ),
                  ],
                ),
              ),
              TaskStatus(
                height: 17.h,
                color: AppColors.completeTaskBGColor,
                label: 'complete',
              ),
              TaskStatus(
                height: 17.h,
                color: AppColors.overdueTaskBGColor,
                label: 'overdueTaskBGColor',
              ),
            ],
          ),
        ),
      ),
      elevation: 5,
    );
  }
}
