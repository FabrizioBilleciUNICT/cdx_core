
import 'package:intl/intl.dart';

abstract class DatesUtils {

  DateTime? parse(String? input, String format) {
    final formatter = DateFormat(format);
    final date = formatter.tryParse(input ?? '');
    return date;
  }

}