import 'package:intl/intl.dart';

String? tryDateFormat(DateFormat formatter, DateTime? value) {
  if (value == null) return null;
  return formatter.format(value);
}
