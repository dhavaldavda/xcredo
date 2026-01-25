import 'package:flutter/material.dart';

enum FontSizeType { xs, sm, base, md, lg, xl, xxl, xxxl, display }

class AppFontSizes {
  static double getFontSize(FontSizeType type) {
    switch (type) {
      case FontSizeType.xs:
        return 10;
      case FontSizeType.sm:
        return 12;
      case FontSizeType.base:
        return 14;
      case FontSizeType.md:
        return 16;
      case FontSizeType.lg:
        return 18;
      case FontSizeType.xl:
        return 20;
      case FontSizeType.xxl:
        return 25;
      case FontSizeType.xxxl:
        return 32;
      case FontSizeType.display:
        return 40;
    }
  }
}

class AppTextStyles {
  static const String _fontFamily = 'Montserrat';

  static TextStyle _style({
    required FontWeight weight,
    FontSizeType sizeType = FontSizeType.base,
    FontStyle style = FontStyle.normal,
    Color? color,
    double? height,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontWeight: weight,
      fontStyle: style,
      fontSize: AppFontSizes.getFontSize(sizeType),
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  // ───────────── Thin (100) ─────────────
  static TextStyle thin([
    FontSizeType size = FontSizeType.base,
    Color? color,
  ]) => _style(weight: FontWeight.w100, sizeType: size, color: color);

  static TextStyle thinItalic([
    FontSizeType size = FontSizeType.base,
    Color? color,
  ]) => _style(
    weight: FontWeight.w100,
    style: FontStyle.italic,
    sizeType: size,
    color: color,
  );

  // ───────────── ExtraLight (200) ─────────────
  static TextStyle extraLight([
    FontSizeType size = FontSizeType.base,
    Color? color,
  ]) => _style(weight: FontWeight.w200, sizeType: size, color: color);

  static TextStyle extraLightItalic([
    FontSizeType size = FontSizeType.base,
    Color? color,
  ]) => _style(
    weight: FontWeight.w200,
    style: FontStyle.italic,
    sizeType: size,
    color: color,
  );

  // ───────────── Light (300) ─────────────
  static TextStyle light([
    FontSizeType size = FontSizeType.base,
    Color? color,
  ]) => _style(weight: FontWeight.w300, sizeType: size, color: color);

  static TextStyle lightItalic([
    FontSizeType size = FontSizeType.base,
    Color? color,
  ]) => _style(
    weight: FontWeight.w300,
    style: FontStyle.italic,
    sizeType: size,
    color: color,
  );

  // ───────────── Regular (400) ─────────────
  static TextStyle regular([
    FontSizeType size = FontSizeType.base,
    Color? color,
  ]) => _style(weight: FontWeight.w400, sizeType: size, color: color);

  static TextStyle italic([
    FontSizeType size = FontSizeType.base,
    Color? color,
  ]) => _style(
    weight: FontWeight.w400,
    style: FontStyle.italic,
    sizeType: size,
    color: color,
  );

  // ───────────── Medium (500) ─────────────
  static TextStyle medium([
    FontSizeType size = FontSizeType.base,
    Color? color,
  ]) => _style(weight: FontWeight.w500, sizeType: size, color: color);

  static TextStyle mediumItalic([
    FontSizeType size = FontSizeType.base,
    Color? color,
  ]) => _style(
    weight: FontWeight.w500,
    style: FontStyle.italic,
    sizeType: size,
    color: color,
  );

  // ───────────── SemiBold (600) ─────────────
  static TextStyle semiBold([
    FontSizeType size = FontSizeType.base,
    Color? color,
  ]) => _style(weight: FontWeight.w600, sizeType: size, color: color);

  static TextStyle semiBoldItalic([
    FontSizeType size = FontSizeType.base,
    Color? color,
  ]) => _style(
    weight: FontWeight.w600,
    style: FontStyle.italic,
    sizeType: size,
    color: color,
  );

  // ───────────── Bold (700) ─────────────
  static TextStyle bold([
    FontSizeType size = FontSizeType.base,
    Color? color,
  ]) => _style(weight: FontWeight.w700, sizeType: size, color: color);

  static TextStyle boldItalic([
    FontSizeType size = FontSizeType.base,
    Color? color,
  ]) => _style(
    weight: FontWeight.w700,
    style: FontStyle.italic,
    sizeType: size,
    color: color,
  );

  // ───────────── ExtraBold (800) ─────────────
  static TextStyle extraBold([
    FontSizeType size = FontSizeType.lg,
    Color? color,
  ]) => _style(weight: FontWeight.w800, sizeType: size, color: color);

  static TextStyle extraBoldItalic([
    FontSizeType size = FontSizeType.lg,
    Color? color,
  ]) => _style(
    weight: FontWeight.w800,
    style: FontStyle.italic,
    sizeType: size,
    color: color,
  );

  // ───────────── Black (900) ─────────────
  static TextStyle black([FontSizeType size = FontSizeType.lg, Color? color]) =>
      _style(weight: FontWeight.w900, sizeType: size, color: color);

  static TextStyle blackItalic([
    FontSizeType size = FontSizeType.lg,
    Color? color,
  ]) => _style(
    weight: FontWeight.w900,
    style: FontStyle.italic,
    sizeType: size,
    color: color,
  );
}
