import 'package:flutter/material.dart';
import 'package:todos_by_bloc/core/extensions/extensions.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.bottomNavigationBar,
    this.backgroundColor,
  });

  final String title;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.colorScheme.inversePrimary,
        title: Text(
          title,
          style: context.theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
          ),
        ),
      ),
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
