import 'package:cdx_core/core/models/base_object.dart';
import 'package:flutter/material.dart';

abstract class Feature<K extends BaseObject> {
  void action(BuildContext context, K object);
}