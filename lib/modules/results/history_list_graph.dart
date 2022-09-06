import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:starfish/src/grpc_extensions.dart';

class HistoryListGraph extends StatefulWidget {
  const HistoryListGraph({
    Key? key,
    required this.monthValuesList,
    this.largestPossible,
    this.headerBuilder,
  }) : super(key: key);

  final List<MonthValues> monthValuesList;
  final int? largestPossible;
  final Widget Function(BuildContext context)? headerBuilder;

  @override
  State<HistoryListGraph> createState() => _HistoryListGraphState();
}

class _HistoryListGraphState extends State<HistoryListGraph> {
  bool isActive = false;
  int _largest = 1;

  static int _calculateLargest(List<MonthValues> monthValuesList) {
    var largest = 1;
    for (final monthValues in monthValuesList) {
      for (final value in monthValues.values.values) {
        if (value > largest) {
          largest = value;
        }
      }
    }
    return largest;
  }

  @override
  void initState() {
    _largest =
        widget.largestPossible ?? _calculateLargest(widget.monthValuesList);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant HistoryListGraph oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.monthValuesList != widget.monthValuesList ||
        oldWidget.largestPossible != widget.largestPossible) {
      _largest =
          widget.largestPossible ?? _calculateLargest(widget.monthValuesList);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (isActive) ...[
          if (widget.headerBuilder != null) widget.headerBuilder!(context),
          Text(
            appLocalizations.history,
            style: TextStyle(
              fontFeatures: [FontFeature.subscripts()],
              color: Color(0xFF434141),
              fontFamily: "OpenSans",
              fontSize: 19.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          ...widget.monthValuesList.map(
            (monthValues) => HistoryListItem(
              monthValues: monthValues,
              largestValue: _largest,
            ),
          ),
        ],
        Center(
          child: TextButton(
            onPressed: () {
              setState(() {
                isActive = !isActive;
              });
            },
            child: Text(
              isActive
                  ? appLocalizations.hideHistory
                  : appLocalizations.viewHistory,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: "Open",
                color: Color(0xFF3475F0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HistoryListItem extends StatelessWidget {
  const HistoryListItem(
      {Key? key, required this.monthValues, required this.largestValue})
      : super(key: key);

  final MonthValues monthValues;
  final int largestValue;

  static const _labelStyle = TextStyle(
    fontFamily: "OpenSans",
    fontSize: 12,
    color: Color(0xFF434141),
  );

  static const _colors = [
    Color(0xFF3475F0),
    Color(0xCD3475F0),
    Color(0x9A3475F0),
  ];

  @override
  Widget build(BuildContext context) {
    final month = monthValues.month;
    final values = monthValues.values;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10.h,
        ),
        Text(
          DateFormat("MMM yyyy")
              .format(DateTime(month.year, month.month)), // eg "JUL 2021",
          style: TextStyle(
            fontFamily: "OpenSans",
            fontSize: 19.sp,
            color: Color(0xFF434141),
          ),
        ),
        SizedBox(
          height: 3.h,
        ),
        ...values.entries.toList().asMap().entries.map((indexEntry) {
          final index = indexEntry.key;
          final entry = indexEntry.value;
          final fraction = entry.value.toDouble() / largestValue;
          final graph = _GraphBar(color: _colors[index]);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 7.h,
              ),
              Text(
                entry.key,
                textAlign: TextAlign.start,
                style: _labelStyle,
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                    child: Text(
                      entry.value.toString(),
                      textAlign: TextAlign.end,
                      style: _labelStyle,
                    ),
                  ),
                  const SizedBox(width: 5),
                  fraction == 0
                      ? SizedBox(width: 10, child: graph)
                      : Expanded(
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: fraction,
                            child: graph,
                          ),
                        ),
                ],
              ),
            ],
          );
        }),
        SizedBox(
          height: 10.h,
        ),
        Divider(
          thickness: 1.0,
          color: Colors.grey,
        ),
      ],
    );
  }
}

class _GraphBar extends StatelessWidget {
  const _GraphBar({Key? key, required this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(7.5),
          bottomRight: Radius.circular(7.5),
        ),
      ),
      child: SizedBox(
        height: 15,
        width: double.infinity,
      ),
    );
  }
}

class MonthValues {
  MonthValues(this.month, this.values);

  Date month;
  Map<String, int> values;
}
