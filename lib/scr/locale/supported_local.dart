part of 'locale_service.dart';

enum SupportedLocale {
  ar_SA(
      locale: Locale("ar", "SA"),
      displayName: "العربية",
      flagPath: "assets/flags/ar_sa.png"),
  bn_BD(
      locale: Locale("bn", "BD"),
      displayName: "বাংলা",
      flagPath: "assets/flags/bn_bd.png"),
  de_DE(
      locale: Locale("de", "DE"),
      displayName: "Deutsch",
      flagPath: "assets/flags/de_de.png"),
  en_US(
      locale: Locale("en", "US"),
      displayName: "English",
      flagPath: "assets/flags/en_us.png"),
  es_ES(
      locale: Locale("es", "ES"),
      displayName: "Español",
      flagPath: "assets/flags/es_es.png"),
  fr_FR(
      locale: Locale("fr", "FR"),
      displayName: "Français",
      flagPath: "assets/flags/fr_fr.png"),
  hi_IN(
      locale: Locale("hi", "IN"),
      displayName: "हिन्दी",
      flagPath: "assets/flags/hi_in.png"),
  id_ID(
      locale: Locale("id", "ID"),
      displayName: "Bahasa Indonesia",
      flagPath: "assets/flags/id_id.png"),
  ja_JP(
      locale: Locale("ja", "JP"),
      displayName: "日本語",
      flagPath: "assets/flags/ja_jp.png"),
  ko_KR(
      locale: Locale("ko", "KR"),
      displayName: "한국어",
      flagPath: "assets/flags/ko_kr.png"),
  pt_BR(
      locale: Locale("pt", "BR"),
      displayName: "Português (Brasil)",
      flagPath: "assets/flags/pt_br.png"),
  pt_PT(
      locale: Locale("pt", "PT"),
      displayName: "Português (Portugal)",
      flagPath: "assets/flags/pt_pt.png"),
  ru_RU(
      locale: Locale("ru", "RU"),
      displayName: "Русский",
      flagPath: "assets/flags/ru_ru.png"),
  tr_TR(
      locale: Locale("tr", "TR"),
      displayName: "Türkçe",
      flagPath: "assets/flags/tr_tr.png"),
  ur_PK(
      locale: Locale("ur", "PK"),
      displayName: "اردو",
      flagPath: "assets/flags/ur_pk.png"),
  zh_CN(
      locale: Locale("zh", "CN"),
      displayName: "简体中文",
      flagPath: "assets/flags/zh_cn.png"),
  zh_TW(
      locale: Locale("zh", "TW"),
      displayName: "繁體中文",
      flagPath: "assets/flags/zh_cn.png");

  final String displayName;
  final String flagPath;
  final Locale locale;

  const SupportedLocale({
    required this.displayName,
    required this.flagPath,
    required this.locale,
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
    return join(SharedConstants.LOCALE_PATH, fileName);
  }
}
