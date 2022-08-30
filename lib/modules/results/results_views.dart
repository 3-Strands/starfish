import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starfish/bloc/my_teacher_admin_role_cubit.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/modules/results/cubit/results_cubit.dart';
import 'package:starfish/modules/results/my_group_results.dart';
import 'package:starfish/modules/results/my_life_results.dart';
import 'package:starfish/modules/settings_view/settings_view.dart';
import 'package:starfish/repositories/data_repository.dart';

import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:starfish/widgets/last_sync_bottom_widget.dart';

class Results extends StatelessWidget {
  const Results({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              MyTeacherAdminRoleCubit(context.read<DataRepository>()),
        ),
        BlocProvider(
          create: (context) => ResultsCubit(context.read<DataRepository>()),
        ),
      ],
      child: const ResultsScreen(),
    );
  }
}

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 64.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AppLogo(hight: 36.h, width: 37.w),
              Text(
                appLocalizations.resultsTabItemText,
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
        backgroundColor: AppColors.resultsScreenBG,
        elevation: 0.0,
      ),
      body: Container(
        color: AppColors.resultsScreenBG,
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
                    return DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          TabBar(
                            indicatorColor: Color(0xFF3475F0),
                            labelColor: Color(0xFF3475F0),
                            labelStyle: TextStyle(
                                fontSize: 19.sp,
                                fontWeight: FontWeight.w600), //For Selected tab
                            unselectedLabelColor: Color(0xFF797979),
                            isScrollable: true,
                            tabs: [
                              Tab(text: appLocalizations.forMyLifeTabText),
                              Tab(text: appLocalizations.forGroupITeachTabText),
                            ],
                            onTap: (index) {
                              // TODO: show results
                              // if (index == 1) {
                              //   context.read<ResultsCubit>().updateUserRole(
                              //       UserGroupRoleFilter.FILTER_ADMIN_CO_LEAD);
                              // } else {
                              //   context.read<ResultsCubit>().updateUserRole(
                              //       UserGroupRoleFilter.FILTER_LEARNER);
                              // }
                            },
                          ),
                          Expanded(
                            child: TabBarView(
                              physics: NeverScrollableScrollPhysics(),
                              children: [MyLifeResults(), MyGroupResults()],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return MyLifeResults();
                  }
                },
              ),
            ),
            LastSyncBottomWidget()
          ],
        ),
      ),
    );
  }
}
