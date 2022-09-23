import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starfish/bloc/my_teacher_admin_role_cubit.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/enums/action_filter.dart';
import 'package:starfish/enums/user_group_role_filter.dart';
import 'package:starfish/modules/actions_view/add_edit_action.dart';
import 'package:starfish/modules/actions_view/cubit/actions_cubit.dart';
import 'package:starfish/modules/actions_view/my_group.dart';
import 'package:starfish/modules/actions_view/me.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/modules/dashboard/cubit/dashboard_navigation_cubit.dart';
import 'package:starfish/modules/settings_view/settings_view.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/utils/currentUser.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:starfish/widgets/last_sync_bottom_widget.dart';

class ActionsView extends StatelessWidget {
  const ActionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              MyTeacherAdminRoleCubit(context.read<DataRepository>()),
        ),
        BlocProvider(
          create: (context) {
            final dashboardTab = context.read<DashboardNavigationCubit>().state;
            final initialFilter =
                dashboardTab is ActionsTab && dashboardTab.group != null
                    ? ActionFilter.ALL_TIME
                    : null;
            return ActionsCubit(
              RepositoryProvider.of<DataRepository>(context),
              initialFilter: initialFilter,
            );
          },
        ),
      ],
      child: const ActionsScreen(),
    );
  }
}

class ActionsScreen extends StatefulWidget {
  const ActionsScreen({Key? key}) : super(key: key);

  @override
  _ActionsScreenState createState() => _ActionsScreenState();
}

class _ActionsScreenState extends State<ActionsScreen>
    with TickerProviderStateMixin {
  //late DataBloc bloc;
  //late HiveCurrentUser _user;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dashboardTab = context.read<DashboardNavigationCubit>().state;
      if (dashboardTab is ActionsTab) {
        final currentTab = dashboardTab.currentTab;
        if (currentTab != null) {
          final index = currentTab == ActionTab.ACTIONS_MY_GROUPS ? 1 : 0;
          _tabController.animateTo(index);
        }
      }
    });
    //_user = CurrentUserProvider().getUserSync();
    // _tabController = new TabController(
    //     length: _user.hasAdminOrTeacherRole ? 2 : 1,
    //     vsync: this,
    //     initialIndex: ActionTab.valueOf(_user.selectedActionsTab) ==
    //             ActionTab.ACTIONS_MY_GROUPS
    //         ? 1
    //         : 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // @override
  // Widget build(BuildContext context) {
  //   final _appLocalizations = AppLocalizations.of(context)!;

  //   return Scaffold(
  //     backgroundColor: AppColors.actionScreenBG,
  //     appBar: AppBar(
  //       title: Container(
  //         height: 64.h,
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: <Widget>[
  //             AppLogo(hight: 36.h, width: 37.w),
  //             Text(
  //               _appLocalizations.actionsTabItemText,
  //               style: dashboardNavigationTitle,
  //             ),
  //             IconButton(
  //               icon: SvgPicture.asset(AssetsPath.settings),
  //               onPressed: () {
  //                 setState(
  //                   () {
  //                     Navigator.pushNamed(
  //                       context,
  //                       Routes.settings,
  //                     );
  //                   },
  //                 );
  //               },
  //             ),
  //           ],
  //         ),
  //       ),
  //       backgroundColor: AppColors.actionScreenBG,
  //       elevation: 0.0,
  //     ),
  //     body: Column(
  //       children: [
  //         TabBar(
  //           controller: _tabController,
  //           indicatorColor: Color(0xFF3475F0),
  //           labelColor: Color(0xFF3475F0),
  //           labelStyle: TextStyle(
  //               fontSize: 19.sp,
  //               fontWeight: FontWeight.w600), //For Selected tab
  //           unselectedLabelColor: Color(0xFF797979),
  //           isScrollable: true,
  //           tabs: List.generate(
  //             _tabController.length,
  //             (index) => Tab(
  //                 text: index == 0
  //                     ? _appLocalizations.forMeTabText
  //                     : _appLocalizations.forGroupITeachTabText),
  //           ),
  //           onTap: (index) {
  //             if (index == 1) {
  //               context
  //                   .read<ActionsCubit>()
  //                   .updateUserRole(UserGroupRoleFilter.FILTER_ADMIN_CO_LEAD);
  //             } else {
  //               context
  //                   .read<ActionsCubit>()
  //                   .updateUserRole(UserGroupRoleFilter.FILTER_LEARNER);
  //             }
  //           },
  //         ),
  //         Expanded(
  //           child: TabBarView(
  //             physics: NeverScrollableScrollPhysics(),
  //             children: _tabController.length == 2
  //                 ? [MyActions(), MyActions()]
  //                 : [MyActions()],
  //             controller: _tabController,
  //           ),
  //         ),
  //       ],
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: () {
  //         Navigator.of(context).pushNamed(Routes.addActions).then(
  //               (value) => FocusScope.of(context).requestFocus(
  //                 new FocusNode(),
  //               ),
  //             );
  //       },
  //       child: Icon(Icons.add),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final _appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 64.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AppLogo(hight: 36.h, width: 37.w),
              Text(
                _appLocalizations.actionsTabItemText,
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
        backgroundColor: AppColors.actionScreenBG,
        elevation: 0.0,
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(color: AppColors.actionScreenBG),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child:
                  BlocBuilder<MyTeacherAdminRoleCubit, MyTeacherAdminRoleState>(
                buildWhen: (previous, current) =>
                    previous.hasAdminOrTeacherRole !=
                    current.hasAdminOrTeacherRole,
                builder: (context, state) {
                  if (state.hasAdminOrTeacherRole) {
                    return Column(
                      children: [
                        TabBar(
                          controller: _tabController,
                          indicatorColor: Color(0xFF3475F0),
                          labelColor: Color(0xFF3475F0),
                          labelStyle: TextStyle(
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w600), //For Selected tab
                          unselectedLabelColor: Color(0xFF797979),
                          isScrollable: true,
                          tabs: [
                            Tab(text: _appLocalizations.forMeTabText),
                            Tab(text: _appLocalizations.forGroupITeachTabText),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            physics: NeverScrollableScrollPhysics(),
                            children: [MyActionsView(), MyGroupActionsView()],
                          ),
                        ),
                      ],
                    );
                  }
                  return MyActionsView();
                },
              ),
            ),
            LastSyncBottomWidget()
          ],
        ),

        // TitleLabel(
        //   title: '',
        //   align: TextAlign.center,
        // ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddEditAction()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
