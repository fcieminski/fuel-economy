import 'package:intl/intl.dart';

class DateFormatter {

  static date(String dateTime){
    return new DateFormat.yMMMMd('pl').format(DateTime.parse(dateTime));
  }
}