import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_by_bloc/core/constants/app_constants.dart';

extension BuildContextExtensions<T> on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  ThemeData get theme => Theme.of(this);

  SharedPreferences get localStorage => sharedPreferences;

  Future<T?> go(Route<T> route) => Navigator.of(this).push(route);

  Future<T?> goNamed(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushNamed(routeName, arguments: arguments);

  void back({T? result}) => Navigator.pop(this, result);

  void backUntil({required bool Function(Route<dynamic>) predicate}) =>
      Navigator.popUntil(this, predicate);
}
