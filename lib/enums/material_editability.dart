import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/navigation_service.dart';

class MaterialEditability {
  final Material_Editability value;
  final String? displayName;

  static final List<Material_Editability> _values = Material_Editability.values;

  static final List<Material_Editability> _hideValues = [
    Material_Editability.UNSPECIFIED_EDITABILITY,
  ];

  MaterialEditability({required this.value, this.displayName});

  static List<MaterialEditability> values() {
    return _values
        .map((Material_Editability element) {
          return MaterialEditability(
              value: element, displayName: element.about);
        })
        .where((element) => !_hideValues.contains(element.value))
        .toList();
  }

  static MaterialEditability valueOf(int index) {
    switch (Material_Editability.valueOf(index)) {
      case Material_Editability.CREATOR_EDIT:
        return MaterialEditability(
            value: Material_Editability.CREATOR_EDIT,
            displayName: Material_Editability.CREATOR_EDIT.about);
      case Material_Editability.GROUP_EDIT:
        return MaterialEditability(
            value: Material_Editability.GROUP_EDIT,
            displayName: Material_Editability.GROUP_EDIT.about);
      default:
        return MaterialEditability(
            value: Material_Editability.UNSPECIFIED_EDITABILITY,
            displayName: Material_Editability.UNSPECIFIED_EDITABILITY.about);
    }
  }
}

extension Material_EditabilityExt on Material_Editability {
  Map<Material_Editability, String> get editabilities => {
        Material_Editability.UNSPECIFIED_EDITABILITY:
            AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
                .unspecifiedEditability,
        Material_Editability.CREATOR_EDIT:
            AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
                .editabilityCreatorEdit,
        Material_Editability.GROUP_EDIT:
            AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
                .editabilityGroupEdit,
      };

  // static const editabilities = {
  //   Material_Editability.UNSPECIFIED_EDITABILITY: 'UNSPECIFIED_EDITABILITY',
  //   Material_Editability.CREATOR_EDIT: Strings.editabilityCreatorEdit,
  //   Material_Editability.GROUP_EDIT: Strings.editabilityGroupEdit,
  // };

  //about property returns the custom message
  String get about => editabilities[this]!;
}
