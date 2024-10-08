import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_by_bloc/config/router/router.dart';
import 'package:todos_by_bloc/core/constants/home_constants.dart';
import 'package:todos_by_bloc/core/extensions/extensions.dart';
import 'package:todos_by_bloc/core/providers/user_bloc/user_bloc.dart';
import 'package:todos_by_bloc/core/services/services.dart';
import 'package:todos_by_bloc/core/widgets/src/app_scaffold.dart';
import 'package:todos_by_bloc/core/widgets/src/image/app_cached_network_image.dart';
import 'package:todos_by_bloc/features/home/bloc/home_bloc.dart';

import '../../favorites/screen/favorites_screen.dart';

import 'home_layout.dart';
import 'home_loading.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final GlobalKey<State<BottomNavigationBar>> bottomNavigationBarKey =
      GlobalKey(debugLabel: "home-bottom-navigation-bar-key");

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listenWhen: (prev, curr) => prev.authStatus != curr.authStatus,
      listener: (BuildContext context, UserState state) {
        if (state.authStatus.isError) {
          DialogService.of(context).showLogin();
        }
      },
      builder: (_, UserState state) {
        if (state.authStatus.isInit || state.authStatus.isProcessing) {
          return const HomeInitial();
        }

        if (state.authStatus.isError) {
          return const SizedBox.shrink();
        }

        return _HomeScreen(key: ValueKey(state.user?.firstName));
      },
    );
  }
}

class _HomeScreen extends StatefulWidget {
  const _HomeScreen({Key? key}) : super(key: key);

  @override
  State<_HomeScreen> createState() => __HomeScreenState();
}

class __HomeScreenState extends State<_HomeScreen> {
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
        BlocSelector<UserBloc, UserState, String>(
          selector: (state) => state.user?.avatarImage ?? "",
          builder: (_, imageUrl) => InkWell(
            onTap: () => context.goNamed(AppRouter.settings.routeName),
            child: CircleAvatar(
              radius: 20,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppCachedNetworkImage(
                  imageUrl: imageUrl,
                  errorWidget: (_, __, ___) => const Icon(Icons.person_2_rounded),
                ),
              ),
            ),
          ),
        ),
      ],
      body: IndexedStack(
        key: const Key("app-layout-body"),
        index: currentTabIndex,
        children: [
          BlocProvider(
            create: (context) => HomeBloc(),
            child: const HomeLayout(),
          ),
          const FavoritesScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        key: HomeScreen.bottomNavigationBarKey,
        currentIndex: currentTabIndex,
        onTap: (int i) => setState(() {
          currentTabIndex = i;
        }),
        selectedItemColor: context.theme.colorScheme.primary,
        items: menuList
            .map<BottomNavigationBarItem>(
              (item) => BottomNavigationBarItem(
                label: item.label == "Home" ? context.localize?.home : context.localize?.favorite,
                icon: item.icon,
              ),
            )
            .toList(),
      ),
    );
  }
}
