part of 'locale_service.dart';

enum SupportedLocale {
  zh_CN(displayName: "中文 (简体)", flagPath: "assets/flags/zh_cn.png"),
  zh_TW(displayName: "中文 (繁體)", flagPath: "assets/flags/zh_cn.png"),
  hi_IN(displayName: "हिन्दी", flagPath: "assets/flags/hi_in.png"),
  en_US(displayName: "English", flagPath: "assets/flags/en_us.png"),
  es_ES(displayName: "Español", flagPath: "assets/flags/es_es.png"),
  pt_BR(displayName: "Português (Brasil)", flagPath: "assets/flags/pt_br.png"),
  pt_PT(
      displayName: "Português (Portugal)", flagPath: "assets/flags/pt_pt.png"),
  fr_FR(displayName: "Français", flagPath: "assets/flags/fr_fr.png"),
  ar_SA(displayName: "العربية", flagPath: "assets/flags/ar_sa.png"),
  bn_BD(displayName: "বাংলা", flagPath: "assets/flags/bn_bd.png"),
  ru_RU(displayName: "Русский", flagPath: "assets/flags/ru_ru.png"),
  de_DE(displayName: "Deutsch", flagPath: "assets/flags/de_de.png"),
  ja_JP(displayName: "日本語", flagPath: "assets/flags/ja_jp.png"),
  tr_TR(displayName: "Türkçe", flagPath: "assets/flags/tr_tr.png"),
  ko_KR(displayName: "한국어", flagPath: "assets/flags/ko_kr.png"),
  id_ID(displayName: "Bahasa Indonesia", flagPath: "assets/flags/id_id.png"),
  ur_PK(displayName: "اردو", flagPath: "assets/flags/ur_pk.png");

  final String displayName;
  final String flagPath;

  const SupportedLocale({
    required this.displayName,
    required this.flagPath,
  });

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      flagPath,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: "alphalogy_kernel",
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
  }) {
    return AssetImage(
      flagPath,
      bundle: bundle,
      package: "alphalogy_kernel",
    );
  }

  Locale get locale {
    var parts = name.split("_");
    return Locale(parts.first, parts.last);
  }

  static SupportedLocale? fromLocale(Locale locale) {
    var name = _convertLocaleToSupportedLocaleName(locale);
    return values.firstWhereOrNull((e) => e.name == name);
  }

  static SupportedLocale? fromString(String name) {
    return values.firstWhereOrNull((e) => e.name == name);
  }

  static String _convertLocaleToSupportedLocaleName(Locale locale) {
    return "${locale.languageCode}_${locale.countryCode}";
  }

  static bool containsLocale(Locale locale) {
    var name = _convertLocaleToSupportedLocaleName(locale);
    return values.any((e) => e.name == name);
  }

  static List<Locale> get supportedLocales =>
      values.map((e) => e.locale).toList();

  static SupportedLocale get deviceSupportedLocale =>
      fromLocale(PlatformDispatcher.instance.locale) ?? SupportedLocale.en_US;

  static List<SupportedLocale> get orderedSupportedLocales {
    Locale deviceLocale = PlatformDispatcher.instance.locale;
    var supportedLocale = fromLocale(deviceLocale);
    var orderedSupportedLocales = [...values];

    //Locale not supported
    if (supportedLocale == null) {
      return orderedSupportedLocales;
    }

    orderedSupportedLocales.remove(supportedLocale);
    orderedSupportedLocales.insert(3, supportedLocale);
    return orderedSupportedLocales;
  }

  String get translatePath {
    var fileName = "$name.json";
    return join("assets/locales/", fileName);
  }
}

extension AppStoreLocaleExtension on AppStoreInterface {
  LocaleService get localeService => LocaleService.instance;
}
