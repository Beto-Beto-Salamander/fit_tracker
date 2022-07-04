// ignore_for_file: avoid_classes_with_only_static_members

import 'package:intl/intl.dart';

extension DateTimeFormatterUtils on DateTime {
  DateTime getDateOnly() => DateTime(year, month, day);

  String getDateFullFormat({bool withDay = false}) =>
      DateFormat('${withDay ? "EEEE," : ""} dd MMMM yyyy').format(this);
}
