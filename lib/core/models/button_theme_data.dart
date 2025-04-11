import 'package:flutter/material.dart';

class CdxButtonThemeData {

  final double? containerHeight;

  final TextStyle textStyle;

  final Color iconColor;

  final EdgeInsets contentPadding;
  final EdgeInsets containerPadding;

  final BorderRadius borderRadius;

  final double borderWidth;

  final double maxWidth;

  CdxButtonThemeData({
    required this.containerHeight,
    required this.textStyle,
    required this.iconColor,
    required this.contentPadding,
    required this.containerPadding,
    required this.borderRadius,
    required this.borderWidth,
    this.maxWidth = double.maxFinite
  });
}
