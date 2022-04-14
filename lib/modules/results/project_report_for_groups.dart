import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProjectReporsForGroup extends StatelessWidget {
  const ProjectReporsForGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            "${AppLocalizations.of(context)!.projectReportFor}",
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
          _buildMarkerStatics(context, 53, 43),
          Divider(
            color: Color(0xFF5D5D5D),
            thickness: 1,
          ),
          _buildMarkerStatics(context, 53, 43),
          Divider(
            color: Color(0xFF5D5D5D),
            thickness: 1,
          ),
          _buildMarkerStatics(context, 126, 22),
          Divider(
            color: Color(0xFF5D5D5D),
            thickness: 1,
          ),
          _buildMarkerStatics(context, 143, 89),
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

  Row _buildMarkerStatics(context, int marker, int actuals) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${AppLocalizations.of(context)!.markers} $marker",
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
              "$actuals",
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
}
