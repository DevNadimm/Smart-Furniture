import 'package:intl/intl.dart';

class DateFormatters {
  DateFormatters._();

  static String readableDate(DateTime date) {
    return DateFormat('MMMM d, yyyy').format(date);
  }
}