import 'package:intl/intl.dart';
import 'package:starfish/src/generated/google/type/date.pb.dart';

void main() {
  print(DateFormat('dd-MMM-yy Hm').format(DateTime(2022, 1, 1, 0, 3)));

  print(Date().month);
  print(Date(year: 1019, month: 0) == Date(year: 1019));
}
