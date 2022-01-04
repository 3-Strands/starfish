import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/navigation_service.dart';

extension ActionTypeExt on Action_Type {
  Map<Action_Type, String> get types => {
        Action_Type.TEXT_INSTRUCTION:
            AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
                .actionTypeTextInstruction,
        Action_Type.TEXT_RESPONSE:
            AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
                .actionTypeTextResponse,
        Action_Type.MATERIAL_INSTRUCTION:
            AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
                .actionTypeMaterialInstruction,
        Action_Type.MATERIAL_RESPONSE:
            AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
                .actionTypeMaterialResponse,
      };

  // static const types = {
  //   Action_Type.TEXT_INSTRUCTION: Strings.actionTypeTextInstruction,
  //   Action_Type.TEXT_RESPONSE: Strings.actionTypeTextResponse,
  //   Action_Type.MATERIAL_INSTRUCTION: Strings.actionTypeMaterialInstruction,
  //   Action_Type.MATERIAL_RESPONSE: Strings.actionTypeMaterialResponse,
  // };

  //about property returns the custom message
  String get about => types[this]!;
}
