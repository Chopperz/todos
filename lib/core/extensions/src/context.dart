import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_by_bloc/core/constants/app_constants.dart';

extension BuildContextExtensions<T> on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  ThemeData get theme => Theme.of(this);

  bool get isDarkMode => theme.brightness == Brightness.dark;

  AppLocalizations? get localize => AppLocalizations.of(this);

  Future<T?> go(Route<T> route) => Navigator.of(this).push(route);

  Future<T?> goNamed(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushNamed(routeName, arguments: arguments);

  void back({T? result}) => Navigator.pop(this, result);

  void backUntil({bool Function(Route<dynamic>)? predicate}) =>
      Navigator.popUntil(this, predicate ?? (route) => false);
}
