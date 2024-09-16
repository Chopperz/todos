import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todos_by_bloc/core/extensions/extensions.dart';
import 'package:todos_by_bloc/core/models/src/user/user_model.dart';
import 'package:todos_by_bloc/core/providers/providers.dart';
import 'package:todos_by_bloc/core/widgets/src/app_scaffold.dart';
import 'package:todos_by_bloc/core/widgets/src/image/app_cached_network_image.dart';
import 'package:todos_by_bloc/theme/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<String> menus = <String>[
    "Profile",
    "Language",
    "Theme",
    "Notifications",
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Settings",
      appBarBackgroundColor: context.theme.scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20).copyWith(top: 12),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: context.theme.cardColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, -1),
                    color: context.theme.shadowColor.withOpacity(.2),
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(10),
              child: BlocSelector<UserBloc, UserState, UserModel?>(
                selector: (state) => state.user,
                builder: (context, user) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 3,
                              ),
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(2),
                            child: CircleAvatar(
                              radius: 75,
                              child: ClipOval(
                                child: AppCachedNetworkImage(
                                  imageUrl: user?.avatarImage,
                                  width: 110,
                                  height: 110,
                                  errorWidget: (_, __, ___) => const Icon(Icons.person_2_rounded),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 90,
                            right: 20,
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                color: context.theme.cardColor,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey.shade200, width: 3),
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.edit,
                                color: Colors.grey,
                                size: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${user?.firstName} ${user?.lastName}",
                              style: AppTheme.fonts.sizeL(
                                props: AppFontStyleProps(fontWeight: FontWeight.w500),
                              ),
                            ),
                            Text(
                              "@${user?.firstName}",
                              style: AppTheme.fonts.sizeS(
                                props: AppFontStyleProps(color: Colors.grey.shade500),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            const Gap(20),
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: context.theme.cardColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, -1),
                      color: context.theme.shadowColor.withOpacity(.2),
                      spreadRadius: 1,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      itemCount: menus.length,
                      itemBuilder: (_, index) {
                        final fontStyle = AppTheme.fonts.sizeL(
                          props: AppFontStyleProps(
                            color: context.isDarkMode ? Colors.grey.shade200 : Colors.grey.shade800,
                            fontWeight: FontWeight.w500,
                          ),
                        );

                        return menus.map((menu) {
                          switch (menu) {
                            case "Theme":
                              return ListTile(
                                title: Text(
                                  menu,
                                  style: fontStyle,
                                ),
                                contentPadding: EdgeInsets.zero,
                                trailing: BlocSelector<SettingsCubit, SettingsState, ThemeMode>(
                                  selector: (state) => state.themeMode,
                                  builder: (_, theme) {
                                    bool isDarkMode = theme == ThemeMode.dark;
                                    return Switch(
                                      value: isDarkMode,
                                      onChanged: (__) {
                                        _.read<SettingsCubit>().onChangedThemeMode(
                                              themeMode:
                                                  isDarkMode ? ThemeMode.light : ThemeMode.dark,
                                            );
                                      },
                                    );
                                  },
                                ),
                              );
                            default:
                              return ListTile(
                                title: Text(
                                  menu,
                                  style: fontStyle,
                                ),
                                contentPadding: EdgeInsets.zero,
                                trailing: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 18,
                                  color: Colors.grey.shade400,
                                ),
                              );
                          }
                        }).elementAt(index);
                      },
                      separatorBuilder: (_, __) => Divider(color: Colors.grey.shade300),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(20),
            Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.only(bottom: 15),
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
    );
  }
}
