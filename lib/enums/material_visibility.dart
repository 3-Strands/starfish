import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/src/generated/starfish.pbjson.dart';

class MaterialVisibility {
  final Material_Visibility value;
  final String? displayName;

  static final List<Material_Visibility> _values = Material_Visibility.values;

  static final List<Material_Visibility> _hideValues = [
    Material_Visibility.CREATOR_VIEW,
    Material_Visibility.UNSPECIFIED_VISIBILITY
  ];

  MaterialVisibility({required this.value, this.displayName});

  static List<MaterialVisibility> values() {
    return _values
        .map((Material_Visibility element) {
          return MaterialVisibility(
              value: element, displayName: getDisplayName(element));
        })
        .where((element) => !_hideValues.contains(element.value))
        .toList();
  }

  static Material_Visibility fromString(String value) {
    switch (value) {
      case 'CREATOR_VIEW':
        return Material_Visibility.CREATOR_VIEW;
      case 'GROUP_VIEW':
        return Material_Visibility.GROUP_VIEW;
      case 'ALL_VIEW':
        return Material_Visibility.ALL_VIEW;
      case 'UNSPECIFIED_VISIBILITY':
      default:
        return Material_Visibility.UNSPECIFIED_VISIBILITY;
    }
  }

  static String? getDisplayName(Material_Visibility material_visibility) {
    switch (material_visibility) {
      case Material_Visibility.ALL_VIEW:
        return 'Anyone at all';
      case Material_Visibility.GROUP_VIEW:
        return 'Groups I teach or administer';
      default:
        return null;
    }
  }
}
