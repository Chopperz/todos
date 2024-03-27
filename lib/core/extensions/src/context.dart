import 'package:flutter/material.dart';

extension BuildContextExtensions<T> on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  ThemeData get theme => Theme.of(this);

  Future<T?> go(Route<T> route) => Navigator.of(this).push(route);

  Future<T?> goNamed(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushNamed(routeName, arguments: arguments);

  void back({T? result}) => Navigator.pop(this, result);
}
