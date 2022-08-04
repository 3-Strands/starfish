import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/models/file_reference.dart';
import 'package:starfish/src/generated/google/type/date.pb.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
export 'package:starfish/src/generated/starfish.pb.dart';

extension DateExt on Date {
  DateTime toDateTime() => DateTime(year, month, day);
}

extension MaterialExt on Material {
  String get key => id;

  List<String> get languageNames => languageIds
      .map(
        (languageId) =>
            globalHiveApi.language.get(languageId)?.name ??
            languages[languageId] ??
            '',
      )
      .toList();

  List<FileReference> get fileReferences => files
      .map((filename) =>
          globalHiveApi.file.get(FileReference.keyFrom(id, filename))!)
      .toList();
}

extension ActionExt on Action {
  Group? get group => globalHiveApi.group.get(groupId);

  bool get isIndividualAction => groupId.isEmpty;

  bool get isPastDueDate => dateDue.toDateTime().isBefore(DateTime.now());
}

extension GroupExt on Group {
  List<User> get fullUsers => users.map((groupUser) => groupUser.user).toList();
}

extension GroupUserExt on GroupUser {
  User get user => globalHiveApi.user.get(userId)!;

  bool get userIsInvitedToGroup {
    final user = this.user;
    return user.phone.isNotEmpty && user.status != User_Status.ACTIVE;
  }
}

extension UserExt on User {
  String get fullPhone => '+${diallingCode.replaceFirst('+', '')} $phone';
}
