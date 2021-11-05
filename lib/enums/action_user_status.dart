import 'package:starfish/enums/action_status.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

extension ActionUser_StatusExt on ActionUser_Status {
  ActionStatus convertTo() {
    switch (this) {
      case ActionUser_Status.COMPLETE:
        return ActionStatus.DONE;
      case ActionUser_Status.INCOMPLETE:
        return ActionStatus.NOT_DONE;
      case ActionUser_Status.UNSPECIFIED_STATUS:
      default:
        return ActionStatus.UNSPECIFIED_STATUS;
    }
  }
}
