import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/navigation_service.dart';

enum ActionFilter {
  THIS_MONTH,
  NEXT_MONTH,
  LAST_MONTH,
  LAST_THREE_MONTH,
  ALL_TIME
}

extension ActionFilterExt on ActionFilter {
  Map<ActionFilter, String> get values => {
        ActionFilter.THIS_MONTH:
            AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
                .actionFilterThisMonth,
        ActionFilter.NEXT_MONTH:
            AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
                .actionFilterNextMonth,
        ActionFilter.LAST_MONTH:
            AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
                .actionFilterLastMonth,
        ActionFilter.LAST_THREE_MONTH:
            AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
                .actionFilterLastThreeMonth,
        ActionFilter.ALL_TIME:
            AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
                .actionFilterAllTime,
      };

  //about property returns the custom message
  String get about => values[this]!;
}
