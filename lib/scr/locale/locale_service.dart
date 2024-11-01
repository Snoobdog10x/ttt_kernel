library ttt_locale;

import 'dart:convert';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

import '../base/ttt_base.dart';
import '../storage/ttt_storage.dart';
import '../stream/ttt_stream.dart';

part 'supported_local.dart';

class LocaleService extends TttService {
  static LocaleService instance = LocaleService._();

  LocaleService._();

  static const String _currentLocaleKey = "current_locale_key";
  final Map<SupportedLocale, Map<String, String>> _translatedTextMap =
      Map.fromEntries(
    SupportedLocale.values.map(
      (e) => MapEntry(e, <String, String>{}),
    ),
  );

  SupportedLocale _currentSupportedLocale =
      SupportedLocale.deviceSupportedLocale;
  late final TttStream<Locale> currentLocaleNotifier =
      TttStream(_currentSupportedLocale.locale);

  Locale get currentLocale => currentLocaleNotifier.value;

  SupportedLocale get currentSupportedLocale => _currentSupportedLocale;

  @override
  Future<void> onDispose() async {}

  @override
  Future<void> onInit() async {
    _loadCurrentLocaleFromStorage();
    await _loadTranslatedTextMap();
  }

  Future<void> _loadTranslatedTextMap() async {
    await Future.wait(SupportedLocale.values.map((supportedLocale) async {
      try {
        var localeContent =
            await rootBundle.loadString(supportedLocale.translatePath);
        Map<String, String> data = Map.from(jsonDecode(localeContent));
        var translatedMap = _translatedTextMap[supportedLocale];
        data.forEach((key, value) {
          key = key.replaceAll("\\n", "\n").replaceAll("n\\", "\n");
          value = value.replaceAll("\\n", "\n").replaceAll("n\\", "\n");
          translatedMap?[key] = value;
        });
      } catch (error) {
        logWarning("Cannot load file ${supportedLocale.name}");
      }
    }));
  }

  bool hasSetLocale() {
    return AppStore.localStorageService.containsKey(_currentLocaleKey);
  }

  void _loadCurrentLocaleFromStorage() {
    var localeString = AppStore.localStorageService.getCache<String>(
      _currentLocaleKey,
    );

    _currentSupportedLocale = SupportedLocale.fromString(localeString ?? "") ??
        SupportedLocale.deviceSupportedLocale;
    currentLocaleNotifier.value = _currentSupportedLocale.locale;
  }

  String translate(String value) {
    var translatedText = _translatedTextMap[_currentSupportedLocale];
    var key = "${value.replaceAll(" ", "_")}_key";
    return translatedText?[key] ?? value;
  }

  Future<void> setCurrentLocale(
    SupportedLocale supportedLocale, {
    bool isOverrideCache = true,
  }) async {
    var localeString = supportedLocale.name;
    _currentSupportedLocale = supportedLocale;
    currentLocaleNotifier.value = supportedLocale.locale;
    if (isOverrideCache) {
      await AppStore.localStorageService.setCache(
        _currentLocaleKey,
        localeString,
      );
    }
    AppStore.forceAppRebuild();
  }

  void addTranslateText(
    SupportedLocale supportedLocale,
    Map<String, String> data,
  ) {
    var localeMap = _translatedTextMap[supportedLocale];
    if (localeMap == null) {
      return;
    }

    localeMap.addAll(data);
  }

  bool get isRTL {
    final TextDirection currentDirection =
        Directionality.of(AppStore.globalContext);
    return currentDirection == TextDirection.rtl;
  }
}
