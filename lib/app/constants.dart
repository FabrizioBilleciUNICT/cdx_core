
import 'dart:ui';

abstract class Constants {

  final String appName;

  final String locale;
  final Map<String, String> locales;
  Iterable<Locale> get supportedLocales => locales.keys.map((e) => Locale(e, ''));

  final String localeCountryCode;
  final List<String> supportedCountryCodes;

  final String baseUrl;

  final String contacts;
  final String termsConditions;
  final String privacyPolicy;
  final String cookiePolicy;

  final String appStoreApp;
  final String playStoreApp;

  final String placeholder;

  const Constants({
    required this.appName,
    required this.locale,
    required this.locales,
    required this.localeCountryCode,
    required this.supportedCountryCodes,
    required this.baseUrl,
    required this.contacts,
    required this.termsConditions,
    required this.privacyPolicy,
    required this.cookiePolicy,
    required this.appStoreApp,
    required this.playStoreApp,
    required this.placeholder,
  });
}
