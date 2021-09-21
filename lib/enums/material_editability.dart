import 'package:starfish/src/generated/starfish.pb.dart';

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
              value: element, displayName: getDisplayName(element));
        })
        .where((element) => !_hideValues.contains(element.value))
        .toList();
  }

  static Material_Editability fromString(String value) {
    switch (value) {
      case 'CREATOR_EDIT':
        return Material_Editability.CREATOR_EDIT;
      case 'GROUP_EDIT':
        return Material_Editability.GROUP_EDIT;
      case 'UNSPECIFIED_EDITABILITY':
      default:
        return Material_Editability.UNSPECIFIED_EDITABILITY;
    }
  }

  static String? getDisplayName(Material_Editability material_editability) {
    switch (material_editability) {
      case Material_Editability.CREATOR_EDIT:
        return 'Only me';
      case Material_Editability.GROUP_EDIT:
        return 'Other Teacher of my Groups';
      default:
        return null;
    }
  }
}
