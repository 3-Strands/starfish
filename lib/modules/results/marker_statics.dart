import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/db/hive_output_marker.dart';

class MarkerStaticRow extends StatefulWidget {
  final HiveOutputMarker outputMarker;
  final String value;

  final markerValueUpdate;

  const MarkerStaticRow(this.outputMarker, this.value,
      {this.markerValueUpdate, Key? key})
      : super(key: key);

  @override
  State<MarkerStaticRow> createState() => _MarkerStaticRowState();
}

class _MarkerStaticRowState extends State<MarkerStaticRow> {
  TextEditingController _markerTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _markerTextEditingController.text = widget.value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "${widget.outputMarker.markerName ?? ""}",
                  style: TextStyle(
                      fontSize: 17.sp,
                      fontFamily: "OpenSans",
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: 50.w,
              ),
              Container(
                height: 50.h,
                width: 100.w,
                color: Color(0xFFFFFFFF),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  controller: _markerTextEditingController,
                  maxLines: 1,
                  onChanged: (value) {
                    //widget.value = int.parse(value);
                    widget.markerValueUpdate(value);
                  },
                  // onSaved: (value) {},
                ),
              ),
            ],
          ),
          Divider(
            color: Color(0xFF5D5D5D),
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
