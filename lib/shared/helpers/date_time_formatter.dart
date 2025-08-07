import 'package:location_based_attendance_app/config/formats.dart';

final class DateTimeFormatter {
  const DateTimeFormatter._();

  static String formatDateTimeWithMonthName(DateTime? dateTime) => dateTime == null
      ? 'Tanggal dan waktu tidak diketahui'
      : '${Formats.dateWithMonthName(dateTime)}, jam ${Formats.timeFromDateTime(dateTime)}';
}
