import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/src/generated/google/type/date.pb.dart';
import 'package:starfish/src/grpc_extensions.dart';

class ProjectReporsForGroup extends StatefulWidget {
  final Group group;
  final Date month;

  const ProjectReporsForGroup(
      {Key? key, required this.group, required this.month})
      : super(key: key);

  @override
  State<ProjectReporsForGroup> createState() => _ProjectReporsForGroupState();
}

class _ProjectReporsForGroupState extends State<ProjectReporsForGroup> {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations _appLocalizations = AppLocalizations.of(context)!;
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
            "${_appLocalizations.projectReportFor} ${widget.group.name}",
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
                "${_appLocalizations.markers}",
                style: TextStyle(
                    fontSize: 17.sp,
                    fontFamily: "OpenSans",
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "${_appLocalizations.actuals}",
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
          _buildMarkerStaticsList(context, widget.group, widget.month),
          // SizedBox(
          //   height: 10.h,
          // ),
          // Container(
          //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
          //   color: Colors.transparent,
          //   width: MediaQuery.of(context).size.width - 20,
          //   //    width: 1000.w,
          //   height: 50.h,
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //         shape: StadiumBorder(), primary: Colors.blue),
          //     onPressed: () {},
          //     child: Text(
          //       "${_appLocalizations.addSignOfTransformation}",
          //       style: TextStyle(fontSize: 17.sp, fontFamily: "OpenSans"),
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 15.h,
          ),
        ],
      ),
    );
  }

  Widget _buildMarkerStaticsList(
      BuildContext context, Group group, Date month) {
    return Container();
    // Map<OutputMarker, String> _outputs = group.getGroupOutputsForMonth(month);
    // return ListView.builder(
    //     shrinkWrap: true,
    //     physics: NeverScrollableScrollPhysics(),
    //     itemCount: _outputs.length,
    //     itemBuilder: (BuildContext context, int index) {
    //       HiveOutputMarker _outputMarker = _outputs.keys.elementAt(index);
    //       return MarkerStaticRow(_outputMarker, _outputs[_outputMarker] ?? '',
    //           markerValueUpdate: (String value) {
    //         if (value.isEmpty) {
    //           return;
    //         }

    //         _saveOutput(group.id!, _outputMarker, month.toMonth, value);
    //       });
    //     });
  }

  // void _saveOutput(String groupId, HiveOutputMarker outputMarker,
  //     HiveDate month, String value) {
  //   HiveOutput? _hiveOutput =
  //       OutputProvider().getGroupOutputForMonth(groupId, outputMarker, month);

  //   if (_hiveOutput == null) {
  //     _hiveOutput = HiveOutput();
  //     _hiveOutput.groupId = groupId;
  //     _hiveOutput.outputMarker = outputMarker;
  //     _hiveOutput.month = month;
  //     _hiveOutput.isNew = true;
  //   } else {
  //     _hiveOutput.isUpdated = true;
  //   }
  //   _hiveOutput.value = value;

  //   OutputProvider().createUpdateOutput(_hiveOutput).then((value) {
  //     debugPrint("Ouput saved.");
  //   }).onError((error, stackTrace) {
  //     debugPrint("Failed to save Output");
  //   });
  // }
}
