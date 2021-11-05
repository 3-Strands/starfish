import 'package:starfish/constants/strings.dart';

enum ActionFilter {
  THIS_MONTH,
  NEXT_MONTH,
  LAST_MONTH,
  LAST_THREE_MONTH,
  ALL_TIME,
}

extension ActionFilterExt on ActionFilter {
  static const values = {
    ActionFilter.THIS_MONTH: Strings.actionFilterThisMonth,
    ActionFilter.NEXT_MONTH: Strings.actionFilterNextMonth,
    ActionFilter.LAST_MONTH: Strings.actionFilterLastMonth,
    ActionFilter.LAST_THREE_MONTH: Strings.actionFilterLastThreeMonth,
    ActionFilter.ALL_TIME: Strings.actionFilterAllTime,
  };

  //about property returns the custom message
  String get about => values[this]!;
}
