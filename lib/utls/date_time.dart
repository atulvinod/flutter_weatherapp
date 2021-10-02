import 'package:intl/intl.dart' as intl;

class DateTimeUtils{
  static String convertUnixToLocal(int unix){
    return intl.DateFormat('h:mm a').format(DateTime.fromMillisecondsSinceEpoch(unix,isUtc:true));
  }
}