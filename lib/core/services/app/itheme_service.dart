import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../models/button_theme_data.dart';
import '../../models/color_set.dart';
import '../../models/input_theme_data.dart';

enum AppTheme { light, dark }

abstract class IThemeService {
  AppTheme _theme = AppTheme.light;

  late final Map<ScreenType, ScreenPadding> _paddings;
  ScreenPadding get paddings => (_paddings[_screenType] ?? _paddings.values.first);

  late final Map<ScreenType, ScreenRadius> _radius;
  ScreenRadius get radius => (_radius[_screenType] ?? _radius.values.first);

  late final Map<ScreenType, ButtonMeasures> _button;
  ButtonMeasures get button => (_button[_screenType] ?? _button.values.first);

  late final Map<ScreenType, InputMeasures> _input;
  InputMeasures get input => (_input[_screenType] ?? _input.values.first);

  late final Map<ScreenType, TextMeasures> _text;
  TextMeasures get text => (_text[_screenType] ?? _text.values.first);

  late final Map<ScreenType, MiscMeasures> _misc;
  MiscMeasures get misc => (_misc[_screenType] ?? _misc.values.first);
  T getMisc<T extends MiscMeasures>() => misc as T;

  void initialize({
    required Map<ScreenType, ScreenPadding> paddings,
    required Map<ScreenType, ScreenRadius> radius,
    required Map<ScreenType, ButtonMeasures> button,
    required Map<ScreenType, InputMeasures> input,
    required Map<ScreenType, TextMeasures> text,
    required Map<ScreenType, MiscMeasures> misc,
  }) {
    _paddings = paddings;
    _radius = radius;
    _button = button;
    _input = input;
    _text = text;
    _misc = misc;
  }

  /// Theme
  ColorSet get light;
  ColorSet get dark;
  /// Theme

  /// Input theme
  CdxInputThemeData get inputTheme;
  /// Input theme

  /// Button theme
  CdxButtonThemeData get buttonTheme;
  /// Button theme

  String get fontFamilyBold;

  ThemeData get themeData;

  ColorSet? _colorConfiguration;

  void setTheme(AppTheme theme) {
    _theme = theme;
    _colorConfiguration = theme == AppTheme.dark ? dark : light;
  }

  ScreenType _screenType = ScreenType.mobile;
  void setScreenType(ScreenType type) => _screenType = type;
  ScreenType get screenType => _screenType;
  bool get isMobile => _screenType == ScreenType.mobile;
  bool get isTablet => _screenType == ScreenType.tablet;
  bool get isDesktop => _screenType == ScreenType.desktop;

  AppTheme get currentTheme => _theme;

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
}