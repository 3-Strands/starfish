// ignore: import_of_legacy_library_into_null_safe

import 'package:dropdown_button2/dropdown_button2.dart';
// ignore: implementation_imports
import 'package:flutter/material.dart' hide Material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/enums/material_filter.dart';
import 'package:starfish/modules/material_view/enum_display.dart';
import 'package:starfish/modules/material_view/single_material_view.dart';
import 'package:starfish/modules/settings_view/settings_view.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/select_items/multi_select.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/helpers/general_functions.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:starfish/widgets/box_builder.dart';
import 'package:starfish/widgets/custon_icon_button.dart';
import 'package:starfish/widgets/last_sync_bottom_widget.dart';
import 'package:starfish/widgets/searchbar_widget.dart';
import 'package:starfish/widgets/task_status.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'cubit/materials_cubit.dart';
// import 'package:starfish/wrappers/file_system.dart';

class Materials extends StatelessWidget {
  const Materials({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MaterialsCubit(RepositoryProvider.of<DataRepository>(context)),
      child: const MaterialsView(),
    );
  }
}

class MaterialsView extends StatefulWidget {
  const MaterialsView({Key? key}) : super(key: key);

  @override
  State<MaterialsView> createState() => _MaterialsViewState();
}

class _MaterialsViewState extends State<MaterialsView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMoreOnEndScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_loadMoreOnEndScroll)
      ..dispose();
    super.dispose();
  }

  void _loadMoreOnEndScroll() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      context.read<MaterialsCubit>().moreRequested();
    }
  }

  void _onMaterialSelection(Material material, ActionStatus? status,
      bool isAssignedToGroupWithLeaderRole) {
    final singleMaterialView = Container(
      height: MediaQuery.of(context).size.height * 0.70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(34.r)),
        color: Color(0xFFEFEFEF),
      ),
      child: SingleMaterialView(
        material: material,
        actionStatus: status,
        isAssignedToGroupWithLeaderRole: isAssignedToGroupWithLeaderRole,
      ),
    );
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
      builder: (BuildContext context) => singleMaterialView,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _appLocalizations = AppLocalizations.of(context)!;
    final dataRepository = context.read<DataRepository>();

    return Scaffold(
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Settings(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        backgroundColor: AppColors.materialSceenBG,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Scrollbar(
              thickness: 5.w,
              thumbVisibility: false,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 14.h),
                    Container(
                      margin: EdgeInsets.only(left: 15.w, right: 15.w),
                      child: BoxBuilder<Language>(
                        box: globalHiveApi.language,
                        builder: (context, values) {
                          return MultiSelect<Language>(
                            navTitle: _appLocalizations.selectLanugages,
                            placeholder: _appLocalizations.selectLanugages,
                            // controller: _languageSelectController,
                            multilineSummary: true,
                            items: values.toList(),
                            initialSelection: Set<Language>.from(
                              context
                                  .read<MaterialsCubit>()
                                  .state
                                  .selectedLanguages
                                  .map((languageId) =>
                                      globalHiveApi.language.get(languageId))
                                  .where((language) => language != null),
                            ),
                            toDisplay: (language) => language.name,
                            onFinished: (Set<Language> selectedLanguages) {
                              context
                                  .read<MaterialsCubit>()
                                  .selectedLanguagesChanged(selectedLanguages);
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      margin: EdgeInsets.only(left: 15.w, right: 15.w),
                      child: BoxBuilder<MaterialTopic>(
                        box: globalHiveApi.materialTopic,
                        builder: (context, values) {
                          return MultiSelect<MaterialTopic>(
                            navTitle: _appLocalizations.selectTopics,
                            placeholder: _appLocalizations.selectTopics,
                            multilineSummary: true,
                            enableSelectAllOption: true,
                            inverseSelectAll: true,
                            items: values.toList(),
                            // initialSelection: bloc.materialBloc.selectedTopics.toSet(),
                            toDisplay: (topic) => topic.name,
                            onFinished: (Set<MaterialTopic> selectedTopics) {
                              context
                                  .read<MaterialsCubit>()
                                  .selectedTopicsChanged(selectedTopics);
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),
                    SearchBar(
                      initialValue: "",
                      onValueChanged: (query) {
                        context.read<MaterialsCubit>().queryChanged(query);
                      },
                      // TODO: This is actually unnecessary, since we update the query on every change.
                      onDone: (_) {},
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
                            child: BlocBuilder<MaterialsCubit, MaterialsState>(
                                buildWhen: (previous, current) =>
                                    previous.actions != current.actions,
                                builder: (context, state) {
                                  return DropdownButton2<MaterialFilter>(
                                    dropdownMaxHeight: 350.h,
                                    offset: Offset(0, -5),
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
                                          state.actions.about,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Color(0xFF434141),
                                        fontSize: 19.sp,
                                        fontFamily: 'OpenSans',
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    onChanged: (MaterialFilter? actions) {
                                      if (actions != null) {
                                        context
                                            .read<MaterialsCubit>()
                                            .actionsChanged(actions);
                                      }
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
                                  );
                                }),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    BlocBuilder<MaterialsCubit, MaterialsState>(
                        builder: (context, state) {
                      final materialsToShow = state.materialsToShow;
                      final materials = materialsToShow.materials;
                      final hasMore = materialsToShow.hasMore;
                      if (materials.isEmpty) {
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
                        itemCount:
                            hasMore ? materials.length + 1 : materials.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          if (index >= materials.length) {
                            return Container(
                              margin:
                                  EdgeInsets.only(left: 15.0.w, right: 15.0.w),
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
                          final materialWithStatus = materials[index];
                          return MaterialListItem(
                            material: materialWithStatus.material,
                            onMaterialTap: _onMaterialSelection,
                            actionStatus: materialWithStatus.status,
                            isAssignedToGroupWithLeaderRole: materialWithStatus
                                .isAssignedToGroupWithLeaderRole,
                          );
                        },
                      );
                    }),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.addNewMaterial);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class MaterialListItem extends StatelessWidget {
  final Material material;
  final Function(
    Material material,
    ActionStatus? status,
    bool isAssignedToGroupWithLeaderRole,
  ) onMaterialTap;
  final ActionStatus? actionStatus;
  final bool isAssignedToGroupWithLeaderRole;

  MaterialListItem({
    required this.material,
    required this.onMaterialTap,
    this.actionStatus,
    required this.isAssignedToGroupWithLeaderRole,
  });

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
          onMaterialTap(
              material, actionStatus, isAssignedToGroupWithLeaderRole);
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
                    if (material.url.isNotEmpty)
                      CustomIconButton(
                        icon: Icon(
                          Icons.open_in_new,
                          color: Colors.blue,
                          size: 21.5.sp,
                        ),
                        text: _appLocalizations.open,
                        onButtonTap: () {
                          GeneralFunctions.openUrl(material.url);
                        },
                      ),
                  ],
                ),
              ),
              if (actionStatus != null || isAssignedToGroupWithLeaderRole) ...[
                SizedBox(
                  height: 16.h,
                ),
                if (actionStatus != null) ...[
                  TaskStatus(
                    height: 17.h,
                    color: actionStatus!.color,
                    label: actionStatus!.toLocaleString(context),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
                if (isAssignedToGroupWithLeaderRole)
                  TaskStatus(
                    height: 17.h,
                    color: Color(0xFFCBE8FA),
                    label: _appLocalizations.assignedToGroup,
                  ),
              ],
              SizedBox(
                height: 10.h,
              ),
              material.files.isNotEmpty
                  ? Text(
                      Intl.plural(material.files.length,
                          one:
                              "${material.files.length} ${_appLocalizations.attachment}",
                          other: "${material.files.length} ${_appLocalizations.attachments}",
                          args: [material.files.length]),
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
