part of 'ttt_ui.dart';

class TttText extends AutoSizeText {
  const TttText(
    super.data, {
    super.key,
    super.textKey,
    super.style,
    super.strutStyle,
    super.minFontSize,
    super.maxFontSize,
    super.stepGranularity,
    super.presetFontSizes,
    super.group,
    super.textAlign,
    super.textDirection,
    super.locale,
    super.softWrap,
    super.wrapWords,
    super.overflow,
    super.overflowReplacement,
    super.textScaleFactor,
    super.maxLines,
    super.semanticsLabel,
  });

  TttText copyWith({
    String? data,
    TextStyle? style,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return TttText(
      data ?? this.data!,
      key: key,
      textKey: textKey,
      style: style ?? this.style,
      strutStyle: strutStyle,
      minFontSize: minFontSize,
      maxFontSize: maxFontSize,
      stepGranularity: stepGranularity,
      presetFontSizes: presetFontSizes,
      group: group,
      textAlign: textAlign ?? this.textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      wrapWords: wrapWords,
      overflow: overflow ?? this.overflow,
      overflowReplacement: overflowReplacement,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines ?? this.maxLines,
      semanticsLabel: semanticsLabel,
    );
  }

  TttText updateStyle({TextStyle? copyStyle}) {
    return copyWith(
      style: copyStyle?.copyWith(
        fontSize: style?.fontSize,
        color: style?.color,
        fontWeight: style?.fontWeight,
        fontStyle: style?.fontStyle,
        letterSpacing: style?.letterSpacing,
        wordSpacing: style?.wordSpacing,
        textBaseline: style?.textBaseline,
        height: style?.height,
        locale: style?.locale,
        foreground: style?.foreground,
        background: style?.background,
        shadows: style?.shadows,
        fontFeatures: style?.fontFeatures,
        decoration: style?.decoration,
        decorationColor: style?.decorationColor,
        decorationStyle: style?.decorationStyle,
        decorationThickness: style?.decorationThickness,
        debugLabel: style?.debugLabel,
        fontFamily: style?.fontFamily,
        fontFamilyFallback: style?.fontFamilyFallback,
        overflow: style?.overflow,
      ),
    );
  }

  static AutoSizeText rich({required List<TttText> children}) {
    return AutoSizeText.rich(
      TextSpan(
        children: children
            .map((e) => TextSpan(text: e.data, style: e.style))
            .toList(),
      ),
      key: children.first.key,
      textKey: children.first.textKey,
      style: children.first.style,
      strutStyle: children.first.strutStyle,
      minFontSize: children.first.minFontSize,
      maxFontSize: children.first.maxFontSize,
      stepGranularity: children.first.stepGranularity,
      presetFontSizes: children.first.presetFontSizes,
      group: children.first.group,
      textAlign: children.first.textAlign,
      textDirection: children.first.textDirection,
      locale: children.first.locale,
      softWrap: children.first.softWrap,
      wrapWords: children.first.wrapWords,
      overflow: children.first.overflow,
      overflowReplacement: children.first.overflowReplacement,
      textScaleFactor: children.first.textScaleFactor,
      maxLines: children.first.maxLines,
      semanticsLabel: children.first.semanticsLabel,
    );
  }
}
