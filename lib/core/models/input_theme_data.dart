import 'package:flutter/material.dart';

class CdxInputThemeData {
  final Color backgroundColor;
  final Color disabledBackgroundColor;

  final double? containerHeight;

  final Color cursorColor;
  final TextStyle textStyle;

  final Color iconColor;

  final EdgeInsets contentPadding;
  final EdgeInsets labelPadding;
  final EdgeInsets containerPadding;

  final TextStyle hintStyle;
  final TextStyle labelTextStyle;
  final TextStyle errorTextStyle;

  final bool outlinedLabel;

  final BorderRadius borderRadius;
  final BorderSide enabledBorder;
  final BorderSide disabledBorder;
  final BorderSide focusedBorder;
  final BorderSide errorBorder;

  CdxInputThemeData({
    required this.backgroundColor,
    required this.disabledBackgroundColor,
    required this.containerHeight,
    required this.cursorColor,
    required this.textStyle,
    required this.iconColor,
    required this.contentPadding,
    required this.hintStyle,
    required this.labelTextStyle,
    required this.labelPadding,
    required this.outlinedLabel,
    required this.containerPadding,
    required this.borderRadius,
    required this.enabledBorder,
    required this.disabledBorder,
    required this.focusedBorder,
    required this.errorBorder,
    required this.errorTextStyle
  });
}
