import 'package:intl/intl.dart';
import 'package:starfish/db/hive_date.dart';

class DateTimeUtils {
  /*static String formatHiveDate(HiveDate hiveDate) {
    String dateString = '${hiveDate.day}-${hiveDate.month}-${hiveDate.year}';
    return formatDate(toDateTime(dateString, 'dd-MM-yyyy'), 'dd-MMM-yyyy');
  }*/

  static String formatHiveDate(HiveDate hiveDate,
      {String requiredDateFormat = 'dd-MMM-yyyy'}) {
    // Handle special case where day is set as 0 to indicate monthly data
    var day = hiveDate.day;
    if (day == 0) {
      day = 1;
    }
    String dateString = '$day-${hiveDate.month}-${hiveDate.year}';
    return formatDate(toDateTime(dateString, 'dd-MM-yyyy'), requiredDateFormat);
  }

  static String formatDate(DateTime dateTime, String requiredDateFormat) {
    final DateFormat formatter = DateFormat(requiredDateFormat);
    return formatter.format(dateTime);
  }

  static DateTime toDateTime(String dateTimeString, String dateFormat) {
    return new DateFormat(dateFormat).parse(dateTimeString);
  }
}
