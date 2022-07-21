import 'package:starfish/db/hive_material.dart';
import 'package:starfish/enums/action_status.dart';

class MaterialWithAssignedStatus {
  const MaterialWithAssignedStatus({
    required this.material,
    this.status,
    this.isAssignedToGroupWithLeaderRole = false,
  });

  final HiveMaterial material;
  final ActionStatus? status;
  final bool isAssignedToGroupWithLeaderRole;
}
