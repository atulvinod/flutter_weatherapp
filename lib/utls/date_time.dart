import 'package:intl/intl.dart' as intl;

class DateTimeUtils {
  static String convertUnixToLocal(int unix) {
    return intl.DateFormat('h:mm a')
        .format(DateTime.fromMicrosecondsSinceEpoch(unix*1000000, isUtc: true).toLocal());
  }

  static String convertUnixToHr(int unix) {
    return intl.DateFormat('h a')
        .format(DateTime.fromMicrosecondsSinceEpoch(unix*1000000, isUtc: true).toLocal());
  }

  static String convertUnixToWeekDay(int unix){
    return intl.DateFormat('EEEE')
        .format(DateTime.fromMicrosecondsSinceEpoch(unix*1000000, isUtc: true).toLocal());
  }
}
