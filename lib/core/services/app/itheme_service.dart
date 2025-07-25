import 'package:cdx_core/app/theme.dart';
import 'package:flutter/material.dart';
import '../../models/button_theme_data.dart';
import '../../models/color_set.dart';
import '../../models/input_theme_data.dart';

enum ThemeType { light, dark }

enum ScreenType { mobile, tablet, desktop, watch }

abstract class IThemeService {
  ThemeType _themeType = ThemeType.light;
  late final ITheme _theme;

  ColorSet get light => _theme.light;
  ColorSet get dark => _theme.dark;
  String get fontFamily => _theme.fontFamily;
  String get fontFamilyBold => _theme.fontFamilyBold;

  ScreenPadding get paddings => (_theme.paddings[_screenType] ?? _theme.paddings.values.first);
  ScreenRadius get radius => (_theme.radius[_screenType] ?? _theme.radius.values.first);
  ButtonMeasures get button => (_theme.button[_screenType] ?? _theme.button.values.first);
  InputMeasures get input => (_theme.input[_screenType] ?? _theme.input.values.first);
  TextMeasures get text => (_theme.text[_screenType] ?? _theme.text.values.first);
  MiscMeasures get misc => (_theme.misc[_screenType] ?? _theme.misc.values.first);
  T getMisc<T extends MiscMeasures>() => misc as T;

  IThemeService({ required ITheme theme }) {
    _theme = theme;
  }

  ThemeData get themeData;

  /// Input theme
  CdxInputThemeData get inputTheme;
  /// Input theme

  /// Button theme
  CdxButtonThemeData get buttonTheme;
  /// Button theme

  ColorSet? _colorConfiguration;

  void setTheme(ThemeType theme) {
    _themeType = theme;
    _colorConfiguration = theme == ThemeType.dark ? dark : light;
  }

  ScreenType _screenType = ScreenType.mobile;
  void setScreenType(ScreenType type) => _screenType = type;
  ScreenType get screenType => _screenType;
  bool get isMobile => _screenType == ScreenType.mobile;
  bool get isTablet => _screenType == ScreenType.tablet;
  bool get isDesktop => _screenType == ScreenType.desktop;

  ThemeType get currentTheme => _themeType;

  ColorSet colors() => _colorConfiguration!;
}


class ScreenPadding {
  final EdgeInsets card;
  final EdgeInsets internalCard;
  final EdgeInsets smallCard;
  final EdgeInsets internalSmallCard;
  final EdgeInsets page;
  final EdgeInsets form;
  final EdgeInsets title;

  const ScreenPadding({
    required this.card,
    required this.internalCard,
    required this.smallCard,
    required this.internalSmallCard,
    required this.page,
    required this.form,
    required this.title
  });
}

class ScreenRadius {
  final BorderRadius card;
  final BorderRadius smallCard;

  const ScreenRadius({
    required this.card,
    required this.smallCard
  });
}

class ButtonMeasures {
  final double containerHeight;
  final double fontSize;
  final EdgeInsets contentPadding;
  final EdgeInsets containerPadding;
  final double borderRadius;
  final double borderWidth;

  const ButtonMeasures({
    required this.containerHeight,
    required this.fontSize,
    required this.contentPadding,
    required this.containerPadding,
    required this.borderRadius,
    required this.borderWidth,
  });
}

class InputMeasures {
  final double containerHeight;
  final double fontSize;
  final EdgeInsets contentPadding;
  final EdgeInsets containerPadding;
  final EdgeInsets labelPadding;
  final double borderRadius;
  final double borderWidth;

  const InputMeasures({
    required this.containerHeight,
    required this.fontSize,
    required this.contentPadding,
    required this.containerPadding,
    required this.labelPadding,
    required this.borderRadius,
    required this.borderWidth,
  });
}

class TextMeasures {
  final double titleSize;
  final double subtitleSize;
  final double textSize;
  final double minorTextSize;

  const TextMeasures({
    required this.titleSize,
    required this.subtitleSize,
    required this.textSize,
    required this.minorTextSize,
  });
}

abstract class MiscMeasures {
  final double maxContentWidth;
  const MiscMeasures({required this.maxContentWidth});
  
  BoxConstraints bottomSheetConstraints(BuildContext context);
}