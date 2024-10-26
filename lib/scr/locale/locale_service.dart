library ttt_locale;

import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

import '../base/app_store.dart';
import '../stream/ttt_stream.dart';

part 'supported_local.dart';

class LocaleService extends TttService {
  static const Locale enUS = Locale("en", "US");
  static const Locale esES = Locale("es", "ES");
  static const Locale frFR = Locale("fr", "FR");
  static const Locale hiIN = Locale("hi", "IN");
  static const Locale ptPT = Locale("pt", "PT");
  static LocaleService instance = LocaleService._();

  LocaleService._();

  final Map<Locale, Map<String, String>> _translatedMap = {};
  final TttStream<Locale> currentLocale = TttStream(enUS);

  void addTranslatedText(Locale locale, Map<String, String> translatedTexts) {
    _translatedMap[locale] ??= {};
    _translatedMap[locale]!.addAll(translatedTexts);
  }

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  List<Locale> get supportedLocales => [enUS, esES, frFR, hiIN, ptPT];

  @override
  InitPriority get initPriority => InitPriority.ON_START_UP;

  @override
  int get order => -1;
}
