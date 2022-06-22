// ignore_for_file: avoid_classes_with_only_static_members

import 'package:intl/intl.dart';

extension DateTimeFormatterUtils on DateTime {
  DateTime getDateOnly() => DateTime(year, month, day);

  String getDateFullFormat() => DateFormat('EEEE, dd MMMM yyyy').format(this);
}
