import 'dart:io';
import 'package:flutter/material.dart';
import '../core/models/t_uple.dart';
import 'package:intl/intl.dart';

extension IntExtension on int {
  String formatTime() {
    int min = this ~/ 60;
    int sec = this % 60;

    return '${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
    //return '${(Duration(seconds: this))}'.split('.')[0].padLeft(8, '0');
  }

  String formatPad({String padValue = '0', int width = 2, bool left = true}) {
    return left
        ? toString().padLeft(width, padValue)
        : toString().padRight(width, padValue);
  }
}

extension DoubleExtension on double {
  String formatSecondToMinutes({bool showSeconds = false}) {
    int min = this ~/ 60;
    int sec = (this % 60).toInt();

    if (min < 1) {
      return showSeconds ? '$sec sec' : '< 1 min';
    }

    return '$min min${showSeconds ? ' ${sec.abs()} sec' : ''}';
  }

  String formatTime() {
    int min = this ~/ 60;
    int sec = (this % 60).toInt();

    return '${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
    //return '${(Duration(seconds: this))}'.split('.')[0].padLeft(8, '0');
  }

  String formatMetersToKm() {
    double km = this / 1000.0;
    return '${km.abs().toStringAsFixed(1)} Km';
  }

  double toPrecision(int n) => double.parse(toStringAsFixed(n));

  String toPrice([bool signAfter = false]) {
    List<String> parts = toPrecision(2).toString().split('.');
    if (parts.length == 1) parts.add('00');
    return '${signAfter ? '':'€'}${parts.first}.${parts.last.padRight(2, '0')}${signAfter ? '€':''}';
  }

  String toPercentage([bool signAfter = true]) {
    List<String> parts = toPrecision(2).toString().split('.');
    if (parts.length == 1) parts.add('00');
    return '${signAfter ? '':'%'}${parts.first}.${parts.last.padRight(2, '0')}${signAfter ? '%':''}';
  }
}

extension StringExtension on String {
  String normalizedNumber() {
    return replaceAll(RegExp(r"[^\d+]+"), '');
  }

  bool isValidE164PhoneNumber() {
    RegExp e164RegExp = RegExp(r'^\+[1-9]\d{9,11}$');
    return e164RegExp.hasMatch(this);
  }

  bool isValidPhoneNumber() {
    RegExp e164RegExp = RegExp(r'^\+?[1-9]\d{9,11}$');
    return e164RegExp.hasMatch(this);
  }

  bool isValidStreetNumber() {
    RegExp exp = RegExp(r'^\d{1,4}(?:\s?[A-Za-z])?\s*$');
    return exp.hasMatch(this);
  }

  bool isValidPassword() {
    return trim().length >= 6;
  }

  bool isValidItalianCF() {
    RegExp regExp = RegExp(r'^[A-Za-z]{6}\d{2}[ABCDEHLMPRST]\d{2}[A-Za-z]\d{3}[A-Za-z]$');
    return regExp.hasMatch(this);
  }

  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\])|(([a-zA-Z\-\d]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  String urlEncoded() {
    return Uri.encodeFull(this);
  }

  Pair<String, String> splitName() {
    List<String> ss = split(" ");
    if (ss.isEmpty) return Pair('', '');
    if (ss.length == 1) return Pair(ss.first, '');

    final String name = ss.first;
    ss.removeAt(0);
    final String surname = ss.reduce((value, element) => '$value $element');
    return Pair(name, surname);
  }

  String extension() {
    return split('/').last.split('.').last.toLowerCase();
  }

  String truncate([int len = 100]) {
    if (length > len) return '${substring(0, len)}...';
    return this;
  }

  String capitalize() {
    if (length < 2) return this;
    return '${substring(0, 1).toUpperCase()}${substring(1)}';
  }

  String removeAccents() {
    final accentRegex = RegExp('[àáâãäåèéêëìíîïòóôõöùúûüýÿñçÀÁÂÃÄÅÈÉÊËÌÍÎÏÒÓÔÕÖÙÚÛÜŸÑÇ]');
    final accentMap = {
      'à': 'a', 'á': 'a', 'â': 'a', 'ã': 'a', 'ä': 'a', 'å': 'a',
      'è': 'e', 'é': 'e', 'ê': 'e', 'ë': 'e',
      'ì': 'i', 'í': 'i', 'î': 'i', 'ï': 'i',
      'ò': 'o', 'ó': 'o', 'ô': 'o', 'õ': 'o', 'ö': 'o',
      'ù': 'u', 'ú': 'u', 'û': 'u', 'ü': 'u',
      'ÿ': 'y',
      'ñ': 'n', 'ç': 'c',
      'À': 'A', 'Á': 'A', 'Â': 'A', 'Ã': 'A', 'Ä': 'A', 'Å': 'A',
      'È': 'E', 'É': 'E', 'Ê': 'E', 'Ë': 'E',
      'Ì': 'I', 'Í': 'I', 'Î': 'I', 'Ï': 'I',
      'Ò': 'O', 'Ó': 'O', 'Ô': 'O', 'Õ': 'O', 'Ö': 'O',
      'Ù': 'U', 'Ú': 'U', 'Û': 'U', 'Ü': 'U',
      'Ÿ': 'Y',
      'Ñ': 'N', 'Ç': 'C'
    };

    return replaceAllMapped(accentRegex, (match) => accentMap[match.group(0)]!);
  }

  String firstLetter() {
    return isNotEmpty ? this[0] : '';
  }

  String cleanHtmlTags() {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return replaceAll(exp, '');
  }
}

extension MapExtension<E> on Map<String, E> {
  Map<String, dynamic> withoutId() {
    if (containsKey("id")) remove("id");
    return this;
  }

  Map<String, dynamic> withoutMetadata() {
    if (containsKey("id")) remove("id");
    // ...
    return this;
  }

  Map<String, String> toStringMap() {
    Map<String, String> s = {};
    forEach((key, value) {
      s[key] = value.toString();
    });
    return s;
  }

  Iterable<E> ordered(int Function(E, E) sort) {
    return values.toList()..sort(sort);
  }

  Map<String, E> toSafe() {
    removeWhere((key, value) => value == null || value.toString().isEmpty);
    return this;
  }

  Map<String, String> toSafeString() {
    return toSafe().map((key, value) => MapEntry(key.toString(), value.toString()));
  }

  Map<String, dynamic> mergeMaps(Map<String, dynamic> itemB,
      {
        bool preferThis = false,
        Set<String>? nonOverridableKeys,
      }
  ) {
    final merged = <String, dynamic>{};
    final allKeys = {...keys, ...itemB.keys};
    nonOverridableKeys ??= {};

    for (var key in allKeys) {
      final valueA = this[key];
      final valueB = itemB[key];

      if (nonOverridableKeys.contains(key) && valueA != null) {
        merged[key] = valueA;
      } else if (valueA != null && valueB != null) {
        merged[key] = preferThis ? valueA : valueB;
      } else if (valueA != null) {
        merged[key] = valueA;
      } else if (valueB != null) {
        merged[key] = valueB;
      } else {
        merged[key] = null;
      }
    }

    return merged;
  }
}

extension ListExtension<E> on List<E> {

  bool anyEmpty(List<String?> list) {
    return list.any((e) => !(e?.isNotEmpty == true));
  }

  void addUnique(E element, bool Function(E) predicate) {
    bool exists = any(predicate);
    if (!exists) {
      add(element);
    }
  }

  void setUnique(E element, bool Function(E) predicate) {
    int index = indexWhere(predicate);
    if (index != -1) {
      this[index] = element;
    } else {
      add(element);
    }
  }

  Iterable<List<E>> chunked(int size) sync* {
    final iterator = this.iterator;
    while (iterator.moveNext()) {
      final current = <E>[];
      do {
        current.add(iterator.current);
      } while (current.length < size && iterator.moveNext());
      yield current.toList(growable: false);
    }
  }

  Pair<List<E>, List<E>> getSplitLists(bool Function(E element) predicate) {
    List<E> listA = [];
    List<E> listB = [];
    for (var element in this) {
      predicate(element) ? listA.add(element) : listB.add(element);
    }
    return Pair(listA, listB);
  }

  List<List<E>> foldToSegments() {
    List<List<E>> folded = [];

    for (int i = 0; i < length - 1; i++) {
      List<E> seg = [];
      seg.add(this[i]);
      seg.add(this[i + 1]);
      folded.add(seg);
    }

    return folded;
  }

  List<List<E>> foldToK([int k = 2]) {
    List<List<E>> folded = [];

    for (int i = 0; i < length; i += k) {
      folded.add(skip(i).take(k).toList());
    }

    return folded;
  }

  List<E> duplicate() {
    return [...this, ...this];
  }

  List<E> ordered(int Function(E, E) sort) {
    return this..sort(sort);
  }

  Pair<E, E> minMax(int Function(E, E) compare) {
    E min = first, max = first;
    for (var i in this) {
      if (compare(i, min) < 0) min = i;
      if (compare(i, max) > 0) max = i;
    }
    return Pair(min, max);
  }

  Map<String, List<E>> groupBy({required String Function(E) key}) {
    Map<String, List<E>> map = {};

    for (E e in this) {
      final k = key(e);
      if (!map.containsKey(k)) map[k] = [];
      map[k]!.add(e);
    }

    return map;
  }

  List<E?> takeAndFill(int count, {E? fillValue}) {
    List<E?> result = cast<E?>().take(count).toList();

    while (result.length < count) {
      result.add(fillValue);
    }

    return result;
  }

  List<E> joinWith(E separator) {
    final result = <E>[];
    for (var i = 0; i < length; i++) {
      result.add(this[i]);
      if (i < length - 1) {
        result.add(separator);
      }
    }
    return result;
  }
}

extension Unique<E, Id> on List<E> {
  List<E> uniques([Id Function(E element)? id, bool inPlace = true]) {
    final ids = <Id>{};
    var list = inPlace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}

extension IterableExtension<T> on Iterable<T> {
  T safeReduce(T Function(T, T) combine, T noElement) {
    return isNotEmpty ? reduce(combine) : noElement;
  }

  Map<T, int> frequency() {
    Map<T, int> f = {};

    for (T item in this) {
      if (!f.containsKey(item)) f[item] = 0;
      f[item] = f[item]! + 1;
    }

    return f;
  }
}

extension DateTimeExtension on DateTime {

  String format([String pattern = 'dd/MM/yyyy', String? locale]) {
    return DateFormat(pattern, locale).format(this);
  }

  bool isSameOrAfterDate(DateTime other) {
    final a = DateTime.parse(format('yyyy-MM-dd'));
    final b = DateTime.parse(other.format('yyyy-MM-dd'));
    return a.isSameDate(b) || a.isAfter(b);
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

extension ColorExtension on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

extension FileExtension on FileSystemEntity {
  String get name {
    return path.split(Platform.pathSeparator).last;
  }
}

extension MapJsonExtension on Map<String, dynamic> {

  List<String>? listString(String key) {
    return (this[key] as List?)?.map((dynamic e) => e.toString()).toList();
  }

  List<T>? listT<T>(String key, T Function(Map<String, dynamic>) creator) {
    return (this[key] as List?)?.map((dynamic e) => creator(e)).toList();
  }

  T? objectT<T>(String key, T Function(Map<String, dynamic>) creator) {
    return (this[key] as Map<String,dynamic>?) != null ? creator(this[key] as Map<String,dynamic>) : null;
  }
}
