import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todos_by_bloc/core/extensions/extensions.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.appBarBackgroundColor,
    this.centerTitle,
    this.actions,
  });

  final String title;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final Color? appBarBackgroundColor;
  final bool? centerTitle;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: appBarBackgroundColor ?? context.theme.colorScheme.inversePrimary,
        title: Text(
          title,
          style: GoogleFonts.prompt(
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            fontSize: 25,
          ),
        ),
        centerTitle: centerTitle,
        actions: (actions != null && actions!.isNotEmpty) ? [
          ...actions!,
          const Gap(15),
        ] : null,
      ),
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
