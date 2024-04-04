part of '../app_theme.dart';

class _AppFonts {
  TextStyle fontS({AppFontStyleProps props = const AppFontStyleProps()}) => GoogleFonts.prompt(
    fontSize: 12,
    fontWeight: props.fontWeight ?? FontWeight.w300,
    letterSpacing: props.letterSpacing,
    color: props.color,
    decoration: props.decoration,
    decorationColor: props.decorationColor,
    decorationStyle: props.decorationStyle,
    decorationThickness: props.decorationThickness,
  );

  TextStyle fontM({AppFontStyleProps props = const AppFontStyleProps()}) => GoogleFonts.prompt(
    fontSize: 14,
    fontWeight: props.fontWeight ?? FontWeight.w300,
    letterSpacing: props.letterSpacing,
    color: props.color,
    decoration: props.decoration,
    decorationColor: props.decorationColor,
    decorationStyle: props.decorationStyle,
    decorationThickness: props.decorationThickness,
  );

  TextStyle fontL({AppFontStyleProps props = const AppFontStyleProps()}) => GoogleFonts.prompt(
    fontSize: 16,
    fontWeight: props.fontWeight ?? FontWeight.w300,
    letterSpacing: props.letterSpacing,
    color: props.color,
    decoration: props.decoration,
    decorationColor: props.decorationColor,
    decorationStyle: props.decorationStyle,
    decorationThickness: props.decorationThickness,
  );

  TextStyle fontXL({AppFontStyleProps props = const AppFontStyleProps()}) => GoogleFonts.prompt(
    fontSize: 18,
    fontWeight: props.fontWeight ?? FontWeight.w300,
    letterSpacing: props.letterSpacing,
    color: props.color,
    decoration: props.decoration,
    decorationColor: props.decorationColor,
    decorationStyle: props.decorationStyle,
    decorationThickness: props.decorationThickness,
  );

  TextStyle fontLarge({AppFontStyleProps props = const AppFontStyleProps()}) => GoogleFonts.prompt(
    fontSize: 20,
    fontWeight: props.fontWeight ?? FontWeight.w300,
    letterSpacing: props.letterSpacing,
    color: props.color,
    decoration: props.decoration,
    decorationColor: props.decorationColor,
    decorationStyle: props.decorationStyle,
    decorationThickness: props.decorationThickness,
  );

  TextStyle fontPrompt({AppFontStyleProps props = const AppFontStyleProps()}) => GoogleFonts.prompt(
    fontSize: props.fontSize,
    fontWeight: props.fontWeight,
    letterSpacing: props.letterSpacing,
    color: props.color,
    decoration: props.decoration,
    decorationColor: props.decorationColor,
    decorationStyle: props.decorationStyle,
    decorationThickness: props.decorationThickness,
  );
}

class AppFontStyleProps {
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final Color? color;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final TextDecorationStyle? decorationStyle;
  final double? decorationThickness;

  const AppFontStyleProps({
    this.fontSize,
    this.fontWeight,
    this.letterSpacing,
    this.color,
    this.decoration,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
  });
}