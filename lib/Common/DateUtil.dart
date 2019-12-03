import 'package:intl/intl.dart';

class DateUtil {
  DateTime now = DateTime.now();

  String format(String format, DateTime date) {
    var formatter = DateFormat(format);
    return formatter.format(date);
  }

  DateTime recentMonday() {
    while (now.weekday != 1) {
      now = now.subtract(new Duration(days: 1));
    }
    return now;
  }

  DateTime addDays(DateTime startDate, int numberOfDays) {
    return startDate.add(new Duration(days: numberOfDays));
  }
}
