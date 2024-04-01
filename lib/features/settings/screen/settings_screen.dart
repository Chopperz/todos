import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todos_by_bloc/core/extensions/extensions.dart';
import 'package:todos_by_bloc/core/providers/providers.dart';
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
      title: "Profile",
      appBarBackgroundColor: context.theme.scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20).copyWith(top: 12),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: context.theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, -1),
                    color: Colors.grey.shade200,
                    spreadRadius: 5,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(),
            ),
            const Gap(20),
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, -1),
                      color: Colors.grey.shade200,
                      spreadRadius: 5,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text(
                              "Theme mode",
                              style: GoogleFonts.prompt(
                                color: Colors.grey.shade800,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            contentPadding: EdgeInsets.zero,
                            trailing: Switch(
                              value: false,
                              onChanged: (v) {},
                            ),
                          ),
                          Divider(color: Colors.grey.shade300),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 15),
                      child: ListTile(
                        onTap: () {
                          context.read<UserBloc>().add(const UserLogoutEvent());
                        },
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                        title: Text(
                          "Logout",
                          style: GoogleFonts.prompt(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: Icon(
                          Icons.logout_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
