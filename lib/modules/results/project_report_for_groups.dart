import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/modules/results/cubit/project_report_cubit.dart';
import 'package:starfish/modules/results/marker_statics.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/src/grpc_extensions.dart';

class ProjectReporsForGroup extends StatelessWidget {
  const ProjectReporsForGroup(
      {Key? key, required this.group, required this.month})
      : super(key: key);

  final Group group;
  final Date month;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      key: ValueKey('${group.id}:${month.year}-${month.month}'),
      create: (context) => ProjectReportCubit(
        dataRepository: context.read<DataRepository>(),
        group: group,
        month: month,
      ),
      child: ProjectReporsForGroupView(),
    );
  }
}

class ProjectReporsForGroupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFF424242),
          borderRadius: BorderRadius.all(Radius.circular(10.r))),
      margin: EdgeInsets.only(left: 15.w, right: 15.w),
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10.h,
          ),
          BlocBuilder<ProjectReportCubit, ProjectReportState>(
            buildWhen: (previous, current) => previous.group != current.group,
            builder: (context, state) {
              return Text(
                "${appLocalizations.projectReportFor} ${state.group.name}",
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontFamily: "OpenSans",
                    fontSize: 19.sp,
                    fontWeight: FontWeight.bold),
              );
            },
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${appLocalizations.markers}",
                style: TextStyle(
                    fontSize: 17.sp,
                    fontFamily: "OpenSans",
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "${appLocalizations.actuals}",
                style: TextStyle(
                  fontSize: 17.sp,
                  fontFamily: "OpenSans",
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          BlocBuilder<ProjectReportCubit, ProjectReportState>(
              builder: (context, state) {
            if (state.outputMarkers.isEmpty) {
              return Container();
            }
            return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: state.outputMarkers.length,
                itemBuilder: (BuildContext context, int index) {
                  final outputMarkerWithValue =
                      state.outputMarkers.elementAt(index);
                  return MarkerStaticRow(
                    outputMarker: outputMarkerWithValue.outputMarker,
                    output: outputMarkerWithValue.output,
                  );
                });
          }),
          SizedBox(
            height: 15.h,
          ),
        ],
      ),
    );
  }
}
