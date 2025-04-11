import 'package:cdx_core/core/models/color_set.dart';
import 'package:get_it/get_it.dart';
import 'core/services/app/iapp_service.dart';
import 'core/services/app/ievent_service.dart';
import 'core/services/app/imedia_service.dart';
import 'core/services/app/itheme_service.dart';

class DI {
  static IMediaService? _media;
  static IMediaService media() => _media ??= GetIt.I.get<IMediaService>();

  static IThemeService? _theme;
  static IThemeService theme() => _theme ??= GetIt.I.get<IThemeService>();
  static ColorSet colors() => theme().colors();

  static IAppService? _app;
  static IAppService app<K>() => _app ??= GetIt.I.get<IAppService>();

  static IEventService? _events;
  static IEventService events<K>() => _events ??= GetIt.I.get<IEventService>();
}
