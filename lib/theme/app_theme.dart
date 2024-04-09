import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

part './src/app_fonts.dart';

part './src/app_mode_color.dart';

class AppTheme with _ThemeModeColor {
  static AppTheme get instance => AppTheme._();

  AppTheme._();

  static _AppFonts get fonts => _AppFonts();
}
