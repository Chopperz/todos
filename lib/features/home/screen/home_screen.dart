import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todos_by_bloc/core/constants/home_constants.dart';
import 'package:todos_by_bloc/core/extensions/extensions.dart';
import 'package:todos_by_bloc/core/providers/user_bloc/user_bloc.dart';
import 'package:todos_by_bloc/core/services/services.dart';
import 'package:todos_by_bloc/core/widgets/src/app_scaffold.dart';
import 'package:todos_by_bloc/features/home/bloc/home_bloc.dart';

import '../../favorites/screen/favorites_screen.dart';

import 'home_layout.dart';

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
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator.adaptive(),
                  const Gap(20),
                  Text(
                    "Authentication Verifying..",
                    style: GoogleFonts.sixtyfour(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          );
        }

        if (state.authStatus.isError) {
          return const SizedBox.shrink();
        }

        return _HomeScreen(key: ValueKey(state.user?.username));
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
          selector: (state) => state.user?.image ?? "",
          builder: (_, imageUrl) => Visibility(
            visible: imageUrl.isNotEmpty,
            child: InkWell(
              onTap: () => Navigator.of(context).pushNamed("/settings"),
              child: CircleAvatar(
                radius: 20,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedNetworkImage(imageUrl: imageUrl),
                ),
              ),
            ),
          ),
        ),
        const Gap(15),
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
        items: menuList.map((item) => item).toList(),
      ),
    );
  }
}
