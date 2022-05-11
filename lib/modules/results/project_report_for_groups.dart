import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_output.dart';
import 'package:starfish/db/hive_output_marker.dart';
import 'package:starfish/db/providers/output_provider.dart';
import 'package:starfish/modules/results/marker_statics.dart';

class ProjectReporsForGroup extends StatefulWidget {
  HiveGroup hiveGroup;
  HiveDate hiveDate;
  ProjectReporsForGroup(
      {Key? key, required this.hiveGroup, required this.hiveDate})
      : super(key: key);

  @override
  State<ProjectReporsForGroup> createState() => _ProjectReporsForGroupState();
}

class _ProjectReporsForGroupState extends State<ProjectReporsForGroup> {
  @override
  Widget build(BuildContext context) {
    //AppBloc bloc = Provider.of(context);
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
            "${AppLocalizations.of(context)!.projectReportFor} ${widget.hiveGroup.name ?? ''}",
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
          _buildMarkerStaticsList(context, widget.hiveGroup, widget.hiveDate),
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
          //       "${AppLocalizations.of(context)!.addSignOfTransformation}",
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
      BuildContext context, HiveGroup hiveGroup, HiveDate hiveDate) {
    //AppBloc bloc = Provider.of(context);
    Map<HiveOutputMarker, String> _outputs =
        hiveGroup.getGroupOutputsForMonth(hiveDate);
    //bloc.resultsBloc.fetchGroupOutputsForMonth();
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _outputs.length,
        itemBuilder: (BuildContext context, int index) {
          HiveOutputMarker _outputMarker = _outputs.keys.elementAt(index);
          return MarkerStaticRow(_outputMarker, _outputs[_outputMarker] ?? '',
              markerValueUpdate: (String value) {
            if (value.isEmpty) {
              return;
            }

            _saveOutput(hiveGroup.id!, _outputMarker, hiveDate.toMonth, value);
          });
        });
  }

  void _saveOutput(String groupId, HiveOutputMarker outputMarker,
      HiveDate month, String value) {
    HiveOutput? _hiveOutput =
        OutputProvider().getGroupOutputForMonth(groupId, outputMarker, month);

    if (_hiveOutput == null) {
      _hiveOutput = HiveOutput();
      _hiveOutput.groupId = groupId;
      _hiveOutput.outputMarker = outputMarker;
      _hiveOutput.month = month;
      _hiveOutput.isNew = true;
    } else {
      _hiveOutput.isUpdated = true;
    }
    _hiveOutput.value = value;

    OutputProvider().createUpdateOutput(_hiveOutput).then((value) {
      debugPrint("Ouput saved.");
    }).onError((error, stackTrace) {
      debugPrint("Failed to save Output");
    });
  }
}
