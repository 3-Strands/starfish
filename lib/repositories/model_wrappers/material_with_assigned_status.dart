import 'package:starfish/enums/action_status.dart';
import 'package:starfish/src/grpc_extensions.dart';

class MaterialWithAssignedStatus {
  const MaterialWithAssignedStatus({
    required this.material,
    this.status,
    this.isAssignedToGroupWithLeaderRole = false,
  });

  final Material material;
  final ActionStatus? status;
  final bool isAssignedToGroupWithLeaderRole;
}
