import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/db/hive_output.dart';

class MarkerStaticRow extends StatefulWidget {
  MarkerStaticRow(this.output, {this.markerValueUpdate, Key? key})
      : super(key: key);
  HiveOutput output;
  final markerValueUpdate;
  @override
  State<MarkerStaticRow> createState() => _MarkerStaticRowState();
}

class _MarkerStaticRowState extends State<MarkerStaticRow> {
  TextEditingController _markerTextEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _markerTextEditingController.text = widget.output.value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            "${widget.output.outputMarker?.markerName ?? ""}",
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
          height: 40.h,
          width: 100.w,
          color: Color(0xFFFFFFFF),
          child: TextFormField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            autofocus: true,
            controller: _markerTextEditingController,
            onChanged: (value) {
              _markerTextEditingController.text = value;
              widget.output.value = int.parse(value);
              widget.markerValueUpdate(value);
            },
            // onSaved: (value) {},
          ),
        ),
      ],
    );
  }
}
