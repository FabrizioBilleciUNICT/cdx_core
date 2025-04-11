import 'package:flutter/material.dart';

class FormArrayItem {
  String id;
  dynamic value;
  bool selected;
  Color? color;
  String? image;

  FormArrayItem(
      {required this.id,
      required this.value,
      this.selected = false,
      this.color,
      this.image});
}
