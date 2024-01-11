import 'package:intl/intl.dart';

class DateTimeHelper {
  static DateTime format() {
    final now = DateTime.now();
    final dateFormat = DateFormat('y/M/d');
    const timeSpecific = "11:00:00";
    final completeFormat = DateFormat('y/M/d H:m:s');

    final todayDate = dateFormat.format(now);
    final todayDateAndTime = "$todayDate $timeSpecific";
    var resultToday = completeFormat.parseStrict(todayDateAndTime);

    return now.isAfter(resultToday) ? resultToday : resultToday.subtract(const Duration(days: 1));
  }
}
