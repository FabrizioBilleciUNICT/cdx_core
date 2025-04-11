import 'package:flutter/services.dart';

class INumericRangeFormatter<T extends num> extends TextInputFormatter {
  final T min;
  final T max;
  final T? Function(String text) tryParse;

  INumericRangeFormatter({
    required this.min,
    required this.max,
    required this.tryParse
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final newValueNumber = tryParse(newValue.text);

    if (newValueNumber == null) {
      return oldValue;
    }

    if (newValueNumber < min) {
      return newValue.copyWith(text: min.toString());
    } else if (newValueNumber > max) {
      return newValue.copyWith(text: max.toString());
    } else {
      return newValue;
    }
  }
}

class NumericRangeFormatter extends INumericRangeFormatter<double> {

  NumericRangeFormatter({
    required super.min,
    required super.max,
  }) : super(tryParse: double.tryParse);
}

class NumericIntRangeFormatter extends INumericRangeFormatter<int> {

  NumericIntRangeFormatter({
    required super.min,
    required super.max,
  }) : super(tryParse: int.tryParse);
}
