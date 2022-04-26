import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/db/hive_output.dart';

class ProjectReporsForGroup extends StatefulWidget {
  const ProjectReporsForGroup({Key? key}) : super(key: key);

  @override
  State<ProjectReporsForGroup> createState() => _ProjectReporsForGroupState();
}

class _ProjectReporsForGroupState extends State<ProjectReporsForGroup> {
  @override
  Widget build(BuildContext context) {
    AppBloc bloc = Provider.of(context);
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
          Text(
            "${AppLocalizations.of(context)!.projectReportFor} ${bloc.resultsBloc.hiveGroup?.name ?? ''}",
            style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontFamily: "OpenSans",
                fontSize: 19.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${AppLocalizations.of(context)!.markers}",
                style: TextStyle(
                    fontSize: 17.sp,
                    fontFamily: "OpenSans",
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "${AppLocalizations.of(context)!.actuals}",
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
          _buildMarkerStaticsList(context),
          Divider(
            color: Color(0xFF5D5D5D),
            thickness: 1,
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width - 20,
            //    width: 1000.w,
            height: 50.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(), primary: Colors.blue),
              onPressed: () {},
              child: Text(
                "${AppLocalizations.of(context)!.addSignOfTransformation}",
                style: TextStyle(fontSize: 17.sp, fontFamily: "OpenSans"),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }

  Widget _buildMarkerStatics(HiveOutput output) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${output.markerName}",
          style: TextStyle(
              fontSize: 17.sp,
              fontFamily: "OpenSans",
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.w600),
        ),
        Container(
          height: 40.h,
          width: 50.w,
          color: Color(0xFFFFFFFF),
          child: Center(
            child: Text(
              "${output.value}",
              style: TextStyle(
                  fontSize: 17.sp,
                  fontFamily: "OpenSans",
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMarkerStaticsList(BuildContext context) {
    AppBloc bloc = Provider.of(context);
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: bloc.resultsBloc.fetchOutputs().length,
        itemBuilder: (BuildContext context, int index) {
          return _buildMarkerStatics(
              bloc.resultsBloc.fetchOutputs().elementAt(index));
        });
  }
}
