import 'package:cdx_core/app/constants.dart';
import 'package:cdx_core/core/models/text_data.dart';
import 'package:flutter/material.dart';
import '../../../app/components.dart';
import '../../../app/mappings.dart';
import '../../models/widget_size.dart';

abstract class IAppService {

  Object? _loc;
  void setLocalization<T>(T loc) => _loc ??= loc;
  T loc<T>() => _loc as T;

  final Mappings _mappings;
  T mappings<T extends Mappings>() => _mappings as T;

  final Components _components;
  T components<T extends Components>() => _components as T;

  final Constants _constants;
  T constants<T extends Constants>() => _constants as T;

  IAppService({
    required Components components,
    required Constants constants,
    required Mappings mappings,
  })
      : _mappings = mappings,
        _components = components,
        _constants = constants;

  String get prefix;

  Widget asset(String icon, {required WidgetSize size, Color? color, BoxFit fit = BoxFit.contain});
  Widget themedAsset(String icon, {required WidgetSize size, Color? color, BoxFit fit = BoxFit.contain});

  Text normal6(String title, {TextData? data});
  Text normal8(String title, {TextData? data});
  Text normal10(String title, {TextData? data});
  Text normal12(String title, {TextData? data});
  Text normal13(String title, {TextData? data});
  Text normal14(String title, {TextData? data});
  Text normal15(String title, {TextData? data});
  Text normal16(String title, {TextData? data});
  Text normal18(String title, {TextData? data});
  Text normal20(String title, {TextData? data});

  Text bold10(String title, {TextData? data});
  Text bold12(String title, {TextData? data});
  Text bold13(String title, {TextData? data});
  Text bold14(String title, {TextData? data});
  Text bold15(String title, {TextData? data});
  Text bold16(String title, {TextData? data});
  Text bold18(String title, {TextData? data});
  Text bold20(String title, {TextData? data});
  Text bold22(String title, {TextData? data});
  Text bold24(String title, {TextData? data});
  Text bold26(String title, {TextData? data});


  void openDialog(BuildContext context, Widget child);
  void openBottomSheet(BuildContext context, Widget child);

  void openAlertDialog(
      BuildContext context,
      String title,
      String message,
      String ok,
      String cancel,
      void Function(bool confirm, BuildContext context) callback
  );

  Future<T?> openFutureDialog<T>(
      BuildContext context,
      Widget Function(BuildContext context) callback, {
        required EdgeInsets insetPadding
      }
  );
}
