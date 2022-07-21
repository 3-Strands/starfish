// ignore: import_of_legacy_library_into_null_safe

import 'package:dropdown_button2/dropdown_button2.dart';
// ignore: implementation_imports
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/db/hive_material_topic.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/enums/material_filter.dart';
import 'package:starfish/modules/material_view/enum_display.dart';
import 'package:starfish/modules/material_view/single_material_view.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/select_items/multi_select.dart';
import 'package:starfish/utils/helpers/general_functions.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
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
      context.read<MaterialsCubit>().loadMore();
    }
  }

  void _onMaterialSelection(HiveMaterial material, ActionStatus? status,
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
                  Navigator.pushNamed(
                    context,
                    Routes.settings,
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
              isAlwaysShown: false,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 14.h),
                    Container(
                      margin: EdgeInsets.only(left: 15.w, right: 15.w),
                      child: StreamBuilder<List<HiveLanguage>>(
                          stream: RepositoryProvider.of<DataRepository>(context)
                              .languages,
                          builder: (context, snapshot) {
                            return MultiSelect<HiveLanguage>(
                              navTitle: _appLocalizations.selectLanugages,
                              placeholder: _appLocalizations.selectLanugages,
                              // controller: _languageSelectController,
                              multilineSummary: true,
                              items: snapshot.data ?? [],
                              toDisplay: HiveLanguage.toDisplay,
                              onFinished:
                                  (Set<HiveLanguage> selectedLanguages) {
                                context
                                    .read<MaterialsCubit>()
                                    .updateSelectedLanguages(selectedLanguages);
                              },
                            );
                          }),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      margin: EdgeInsets.only(left: 15.w, right: 15.w),
                      child: StreamBuilder<List<HiveMaterialTopic>>(
                          stream: RepositoryProvider.of<DataRepository>(context)
                              .materialTopics,
                          builder: (context, snapshot) {
                            return MultiSelect<HiveMaterialTopic>(
                              navTitle: _appLocalizations.selectTopics,
                              placeholder: _appLocalizations.selectTopics,
                              multilineSummary: true,
                              enableSelectAllOption: true,
                              inverseSelectAll: true,
                              items: snapshot.data ?? [],
                              // initialSelection: bloc.materialBloc.selectedTopics.toSet(),
                              toDisplay: HiveMaterialTopic.toDisplay,
                              onFinished:
                                  (Set<HiveMaterialTopic> selectedTopics) {
                                context
                                    .read<MaterialsCubit>()
                                    .updateSelectedTopics(selectedTopics);
                              },
                            );
                          }),
                    ),
                    SizedBox(height: 10.h),
                    SearchBar(
                      initialValue: "",
                      onValueChanged: (query) {
                        context.read<MaterialsCubit>().updateQuery(query);
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
                                            .updateActions(actions);
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
  final HiveMaterial material;
  final Function(
    HiveMaterial material,
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
              material.fileNames.isNotEmpty
                  ? Text(
                      Intl.plural(material.fileNames.length,
                          one:
                              "${material.fileNames.length} ${_appLocalizations.attachment}",
                          other: "${material.fileNames.length} ${_appLocalizations.attachments}",
                          args: [material.fileNames.length]),
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
