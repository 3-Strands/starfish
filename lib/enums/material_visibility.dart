import 'package:starfish/constants/strings.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

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
          return MaterialVisibility(value: element, displayName: element.about);
        })
        .where((element) => !_hideValues.contains(element.value))
        .toList();
  }
}

extension Material_VisibilityExt on Material_Visibility {
  static const visibilities = {
    Material_Visibility.UNSPECIFIED_VISIBILITY: 'UNSPECIFIED_VISIBILITY',
    Material_Visibility.CREATOR_VIEW: 'CREATOR_VIEW',
    Material_Visibility.GROUP_VIEW: Strings.visibilityGroupView,
    Material_Visibility.ALL_VIEW: Strings.visibilityAllView,
  };

  //about property returns the custom message
  String get about => visibilities[this]!;
}
