import 'dart:ui';

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

  IAppService({
    required Mappings mappings,
    required Components components,
  })
      : _mappings = mappings,
        _components = components;

  String get prefix;

  Widget asset(String icon, {required WidgetSize size, Color? color, BoxFit fit = BoxFit.contain});
  Widget themedAsset(String icon, {required WidgetSize size, Color? color, BoxFit fit = BoxFit.contain});

  Text normal6(String title, {int? maxLines, TextAlign? align});
  Text normal8(String title, {int? maxLines, TextAlign? align});
  Text normal10(String title, {int? maxLines, TextAlign? align, Color? color});
  Text normal12(String title, {int? maxLines, TextAlign? align});
  Text normal13(String title, {int? maxLines, TextAlign? align});
  Text normal14(String title, {int? maxLines, TextAlign? align});
  Text normal15(String title, {int? maxLines, TextAlign? align});
  Text normal16(String title, {int? maxLines, TextAlign? align});
  Text normal18(String title, {int? maxLines, TextAlign? align});
  Text normal20(String title, {int? maxLines, TextAlign? align});

  Text bold10(String title, {int? maxLines, TextAlign? align, Color? color});
  Text bold12(String title, {int? maxLines, TextAlign? align});
  Text bold13(String title, {int? maxLines, TextAlign? align});
  Text bold14(String title, {int? maxLines, TextAlign? align, String? family});
  Text bold15(String title, {int? maxLines, TextAlign? align});
  Text bold16(String title, {int? maxLines, TextAlign? align, String? family});
  Text bold18(String title, {int? maxLines, TextAlign? align, String? family});
  Text bold20(String title, {int? maxLines, TextAlign? align, String? family, Color? color});
  Text bold22(String title, {int? maxLines, TextAlign? align, String? family});
  Text bold24(String title, {int? maxLines, TextAlign? align, String? family});
  Text bold26(String title, {int? maxLines, TextAlign? align, String? family});


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
