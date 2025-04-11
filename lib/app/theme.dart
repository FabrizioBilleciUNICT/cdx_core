
import '../core/models/color_set.dart';
import '../core/services/app/itheme_service.dart';

abstract class ITheme {

  final Map<ScreenType, ScreenPadding> paddings;
  final Map<ScreenType, ScreenRadius> radius;
  final Map<ScreenType, ButtonMeasures> button;
  final Map<ScreenType, InputMeasures> input;
  final Map<ScreenType, TextMeasures> text;
  final Map<ScreenType, MiscMeasures> misc;

  final String fontFamilyBold;
  final String fontFamily;
  final ColorSet light;
  final ColorSet dark;

  const ITheme({
    required this.paddings,
    required this.radius,
    required this.button,
    required this.input,
    required this.text,
    required this.misc,
    required this.fontFamilyBold,
    required this.fontFamily,
    required this.light,
    required this.dark,
  });
}