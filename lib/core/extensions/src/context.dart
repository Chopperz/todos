import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  ThemeData get theme => Theme.of(this);
}