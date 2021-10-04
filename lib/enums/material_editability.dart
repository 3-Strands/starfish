import 'package:starfish/constants/strings.dart';
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
              value: element, displayName: element.about);
        })
        .where((element) => !_hideValues.contains(element.value))
        .toList();
  }
}

extension Material_EditabilityExt on Material_Editability {
  static const editabilities = {
    Material_Editability.UNSPECIFIED_EDITABILITY: 'UNSPECIFIED_EDITABILITY',
    Material_Editability.CREATOR_EDIT: Strings.editabilityCreatorEdit,
    Material_Editability.GROUP_EDIT: Strings.editabilityGroupEdit,
  };

  //about property returns the custom message
  String get about => editabilities[this]!;
}
