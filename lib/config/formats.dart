import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final class Formats {
  const Formats._();

  static String _twoDigits(int integer) => integer.toString().padLeft(2, '0');

  static String date(DateTime dateTime) => '${_twoDigits(dateTime.day)}-${_twoDigits(dateTime.month)}-${dateTime.year}';

  static String dateWithMonthName(DateTime dateTime) => DateFormat('d MMMM yyyy', 'id_ID').format(dateTime);

  static String _time(TimeOfDay timeOfDay) => '${_twoDigits(timeOfDay.hour)}:${_twoDigits(timeOfDay.minute)}';

  static String timeFromDateTime(DateTime dateTime) => _time(TimeOfDay.fromDateTime(dateTime));

  static String timeFromTimeOfDay(TimeOfDay timeOfDay) => _time(timeOfDay);
}
