import 'package:flutter/material.dart';
import 'package:todos_by_bloc/core/extensions/extensions.dart';
import 'package:todos_by_bloc/core/widgets/src/app_scaffold.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Settings",
      centerTitle: false,
      appBarBackgroundColor: context.theme.scaffoldBackgroundColor,
      body: Column(),
    );
  }
}
