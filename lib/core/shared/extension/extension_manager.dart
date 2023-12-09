import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeFormat on DateTime {
  String get formatDate => DateFormat('dd - MM - yyyy').format(this);

  String get formatCardDate => DateFormat('MM/yy').format(this);

  String get mdy => DateFormat('MM/dd/yyyy').format(this);

  String get hm => DateFormat(DateFormat.HOUR_MINUTE).format(this);

  String get dayAndHour => DateFormat('Hm').format(this);

  String get gregorianDate =>
      DateFormat('E, d MMM yyyy HH:mm').format(toLocal());

  String get gregorianDateWithoutTime =>
      DateFormat('EEEE, dd MMM yyyy').format(this);

  String get complaintDateFormat =>
      DateFormat('MMM dd, yyyy h:MM aaa').format(this);

  DateTime beforeOneYear() => DateTime(year - 1, month, day);

  DateTime beforeNYear(int n) => DateTime(year - n, month, day);

  DateTime afterOneYear() => DateTime(year + 1, month, day);

  DateTime afterNYear(int n) => DateTime(year + n, month, day);
}

extension DateTimeParsing on DateTime {
  /// parse [time] in "hh:mm" format.
  static String tryParseTimeHM(TimeOfDay time) {
    int h = int.parse(time.hour.toString());
    int m = int.parse(time.minute.toString());
    DateTime dateTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      h,
      m,
    );
    DateFormat format = DateFormat('h:mm a');
    String formattedTime = format.format(dateTime);
    return formattedTime;
  }
}
