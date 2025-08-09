import 'package:intl/intl.dart';

class DateFormatters {
  DateFormatters._();

  static String readableDate(String? date) {
    if (date == null || date.isEmpty) return "-";
    try {
      final parsedDate = DateTime.parse(date);
      return DateFormat('MMMM d, yyyy').format(parsedDate);
    } catch (e) {
      return date;
    }
  }
}
