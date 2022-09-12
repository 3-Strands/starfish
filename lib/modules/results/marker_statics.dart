import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/modules/results/cubit/project_report_cubit.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/widgets/focusable_text_field.dart';

class MarkerStaticRow extends StatefulWidget {
  final OutputMarker outputMarker;
  final Output? output;

  const MarkerStaticRow({Key? key, required this.outputMarker, this.output})
      : super(key: key);

  @override
  State<MarkerStaticRow> createState() => _MarkerStaticRowState();
}

class _MarkerStaticRowState extends State<MarkerStaticRow> {
  TextEditingController _markerTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _markerTextEditingController.text =
        widget.output != null ? widget.output!.value.toString() : '';
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
                  "${widget.outputMarker.markerName}",
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
                //color: Color(0xFFFFFFFF),
                child: FocusableTextField(
                  textAlign: TextAlign.center,
                  initialValue: '${widget.output?.value ?? 0}',
                  keyboardType: TextInputType.number,
                  controller: _markerTextEditingController,
                  maxLines: 1,
                  onFieldSubmitted: (value) {
                    context.read<ProjectReportCubit>().updateOuputMarkerValue(
                          outputMarker: widget.outputMarker,
                          output: widget.output,
                          value: Int64.parseInt(value),
                        );
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
