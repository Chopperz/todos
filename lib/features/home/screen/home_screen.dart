import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_by_bloc/core/constants/home_constants.dart';
import 'package:todos_by_bloc/core/extensions/extensions.dart';
import 'package:todos_by_bloc/core/providers/user_bloc/user_bloc.dart';
import 'package:todos_by_bloc/core/widgets/src/app_scaffold.dart';

import '../../favorites/screen/favorites_screen.dart';
import '../../settings/screen/settings_screen.dart';

part 'home_layout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static final GlobalKey<State<BottomNavigationBar>> bottomNavigationBarKey =
      GlobalKey(debugLabel: "home-bottom-navigation-bar-key");

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      key: const Key("app-layout-screen"),
      title: menuList.elementAt(currentTabIndex).label ?? "-",
      appBarBackgroundColor: context.theme.scaffoldBackgroundColor,
      centerTitle: false,
      actions: [
        Visibility(
          visible: currentTabIndex == 0,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_basket),
          ),
        ),
        IconButton(
          onPressed: () async {
            await Navigator.pushNamed(context, "/settings");
          },
          icon: const Icon(Icons.settings),
        ),
      ],
      body: IndexedStack(
        key: const Key("app-layout-body"),
        index: currentTabIndex,
        children: [
          const HomeLayout(),
          const FavoritesScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        key: HomeScreen.bottomNavigationBarKey,
        currentIndex: currentTabIndex,
        onTap: (int i) => setState(() {
          currentTabIndex = i;
        }),
        items: menuList.map((item) => item).toList(),
      ),
    );
  }
}
