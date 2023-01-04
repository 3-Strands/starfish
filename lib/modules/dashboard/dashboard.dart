import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/modules/dashboard/cubit/dashboard_navigation_cubit.dart';
import 'package:starfish/modules/actions_view/actions_view.dart';
import 'package:starfish/modules/groups_view/groups_view.dart';
import 'package:starfish/modules/material_view/materials_view.dart';
import 'package:starfish/modules/results/results_views.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardNavigationCubit(),
      child: const DashboardView(),
    );
  }
}

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late PageController _pageController;

  @override
  void initState() {
    // if (!Platform.isWeb) {
    //   // Sync every 15 mins
    //   cron.schedule(Schedule.parse('*/15 * * * *'), () async {
    //     debugPrint('================ START SYNC =====================');
    //     SyncService().syncAll();
    //   });
    // }
    // FBroadcast.instance().register(SyncService.kUpdateMaterial,
    //     (hiveMaterial, __) {
    //   debugPrint('Boradcast Receiver: kUpdateMaterial');
    //   SyncService().syncLocalMaterialsToRemote();
    //   SyncService().syncLocalFiles();
    // }, more: {
    //   SyncService.kUpdateTeacherResponse: (hiveTeacherResponse, __) {
    //     debugPrint('Boradcast Receiver: kUpdateTeacherResponse');
    //     SyncService().syncLocalTeacherResponsesToRemote();
    //   },
    //   SyncService.kUpdateTransformation: (hiveTransformation, __) {
    //     debugPrint('Boradcast Receiver: kUpdateTransformation');
    //     SyncService().syncLocalTransformationsToRemote();
    //     SyncService().syncLocalFiles();
    //   },
    //   SyncService.kUpdateLearnerEvaluation: (hiveLearnerEvaluation, __) {
    //     debugPrint('Boradcast Receiver: kUpdateLearnerEvaluation');
    //     SyncService().syncLocalLearnerEvaluationsToRemote();
    //   },
    //   SyncService.kDeleteMaterial: (hiveMaterial, __) {
    //     debugPrint('Boradcast Receiver: kDeleteMaterial');
    //     SyncService().syncLocalDeletedMaterialsToRemote();
    //   },
    //   SyncService.kUpdateGroup: (hiveGroup, __) {
    //     SyncService().syncLocalUsersAndGroups();
    //   },
    //   SyncService.kUpdateUsers: (hiveUsers, __) {
    //     debugPrint('Boradcast Receiver: kUpdateUsers');
    //     SyncService().syncLocalUsersAndGroups();
    //   },
    //   SyncService.kUpdateCurrentUser: (hiveCurrentUser, __) {
    //     debugPrint('Boradcast Receiver: kUpdateCurrentUser');
    //     SyncService().syncLocalCurrentUser(kCurrentUserFieldMask);
    //   },
    //   SyncService.kUnauthenticated: (value, callback) {
    //     debugPrint('Boradcast Receiver: kUnauthenticated');
    //     handleUnauthentication();
    //   },
    //   "switchToActionTab": (value, callback) {
    //     debugPrint('Boradcast Receiver: switchToActionTab');
    //     onTabTapped(2);
    //     bloc.actionBloc.selectedTabIndex = 1;
    //     bloc.actionBloc.focusedGroup = value as HiveGroup;
    //   }
    // }, context: this);

    // _user = CurrentUserProvider().getCurrentUserSync();
    // SyncService().syncAll().whenComplete(() {
    //   if (_user == null) {
    //     _getCurrentUser();
    //   }
    // });

    // var materialsWidget = MaterialsScreen();
    // var groupsWidget = GroupsScreen();
    // var actionsWidget = ActionsScreen();
    // var resultsWidget = ResultsScreen();

    _pageController = PageController(initialPage: 1);

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocListener<DashboardNavigationCubit, DashboardNavigationTab>(
      listener: (context, state) {
        if (_pageController.page!.round() != state.index) {
          _pageController.animateToPage(
            state.index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: PageView.builder(
          onPageChanged: onPageChanged,
          controller: _pageController,
          itemCount: 4,
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return const Materials();
              case 1:
                return const Groups();
              case 2:
                return const ActionsView();
              default:
                return const Results();
            }
          },
        ),
        bottomNavigationBar:
            BlocBuilder<DashboardNavigationCubit, DashboardNavigationTab>(
          builder: (context, state) {
            final index = state.index;
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(AssetsPath.metericalsActiveIcon),
                  icon: SvgPicture.asset(AssetsPath.metericalsIcon),
                  label: appLocalizations.materialsTabItemText,
                ),
                BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(AssetsPath.groupsActiveIcon),
                  icon: SvgPicture.asset(AssetsPath.groupsIcon),
                  label: appLocalizations.groupsTabItemText,
                ),
                BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(AssetsPath.actionsActiveIcon),
                  icon: SvgPicture.asset(AssetsPath.actionsIcon),
                  label: appLocalizations.actionsTabItemText,
                ),
                BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(AssetsPath.resultsActiveIcon),
                  icon: SvgPicture.asset(AssetsPath.resultsIcon),
                  label: appLocalizations.resultsTabItemText,
                ),
              ],
              currentIndex: index,
              selectedItemColor: _selectedTabColor(index),
              backgroundColor: AppColors.txtFieldBackground,
              unselectedItemColor: AppColors.unselectedButtonBG,
              unselectedFontSize: 14.sp,
              selectedFontSize: 14.sp,
              onTap: onTabTapped,
            );
          },
        ),
      ),
    );
  }

  void onPageChanged(int index) {
    context
        .read<DashboardNavigationCubit>()
        .navigationRequested(DashboardNavigationTab.tabs[index]);
  }

  void onTabTapped(int index) {
    context
        .read<DashboardNavigationCubit>()
        .navigationRequested(DashboardNavigationTab.tabs[index]);
  }

  Color _selectedTabColor(int index) {
    switch (index) {
      case 3:
        return AppColors.resultsTabBarTextColor;
      case 2:
        return AppColors.actionTabBarTextColor;
      case 1:
        return AppColors.groupTabBarTextColor;
      case 0:
      default:
        return AppColors.materialTabBarTextColor;
    }
  }
}
