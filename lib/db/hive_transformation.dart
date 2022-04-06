import 'package:hive/hive.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

part 'hive_transformation.g.dart';

@HiveType(typeId: 21)
class HiveTransformation extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? userId;
  @HiveField(2)
  String? groupId;
  @HiveField(3)
  HiveDate? month;
  @HiveField(4)
  String? impactStory;
  @HiveField(5)
  List<String>? files;
  @HiveField(6)
  bool isNew = false;
  @HiveField(7)
  bool isUpdated = false;
  @HiveField(8)
  bool isDirty = false;

  HiveTransformation({
    this.id,
    this.userId,
    this.groupId,
    this.month,
    this.impactStory,
  });

  HiveTransformation.from(Transformation transformation) {
    this.id = transformation.id;
    this.userId = transformation.userId;
    this.groupId = transformation.groupId;
    this.month = HiveDate.from(transformation.month);
    this.impactStory = transformation.impactStory;
    this.files = transformation.files;
  }

  Transformation toTransformation() {
    return Transformation(
      id: this.id,
      userId: this.userId,
      groupId: this.groupId,
      month: this.month?.toDate(),
      impactStory: this.impactStory,
      files: this.files,
    );
  }

  @override
  String toString() {
    return super.toString();
  }
}
