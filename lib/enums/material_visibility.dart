import 'package:flutter/material.dart';
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

  static MaterialVisibility valueOf(int index) {
    switch (Material_Visibility.valueOf(index)) {
      case Material_Visibility.ALL_VIEW:
        return MaterialVisibility(
            value: Material_Visibility.ALL_VIEW,
            displayName: Material_Visibility.ALL_VIEW.about);
      case Material_Visibility.GROUP_VIEW:
        return MaterialVisibility(
            value: Material_Visibility.GROUP_VIEW,
            displayName: Material_Visibility.GROUP_VIEW.about);
      case Material_Visibility.CREATOR_VIEW:
        return MaterialVisibility(
            value: Material_Visibility.CREATOR_VIEW,
            displayName: Material_Visibility.CREATOR_VIEW.about);
      default:
        return MaterialVisibility(
            value: Material_Visibility.UNSPECIFIED_VISIBILITY,
            displayName: Material_Visibility.UNSPECIFIED_VISIBILITY.about);
    }
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
