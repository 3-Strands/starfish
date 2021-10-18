import 'package:starfish/constants/strings.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

extension ActionTypeExt on Action_Type {
  static const types = {
    Action_Type.TEXT_INSTRUCTION: Strings.actionTypeTextInstruction,
    Action_Type.TEXT_RESPONSE: Strings.actionTypeTextResponse,
    Action_Type.MATERIAL_INSTRUCTION: Strings.actionTypeMaterialInstruction,
    Action_Type.MATERIAL_RESPONSE: Strings.actionTypeMaterialResponse,
  };

  //about property returns the custom message
  String get about => types[this]!;
}
