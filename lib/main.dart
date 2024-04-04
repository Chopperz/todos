import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_by_bloc/core/providers/providers.dart';
import 'package:todos_by_bloc/core/services/dio/dio_service.dart';
import 'package:todos_by_bloc/theme/app_theme.dart';

import 'config/router/router.dart';
import 'core/constants/app_constants.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final dir = await getTemporaryDirectory();
  appDirectoryPath = dir.path;
  HydratedBloc.storage = await HydratedStorage.build(storageDirectory: dir);
  sharedPreferences = await SharedPreferences.getInstance();
  await dotenv.load(fileName: ".env");
  await DioService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          UserBloc(context)
            ..add(const FetchUserEvent()),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => FavoritesBloc(),
        ),
        BlocProvider(
          create: (context) => SettingsCubit(),
        ),
      ],
      child: BlocSelector<SettingsCubit, SettingsState, ThemeMode>(
        selector: (state) => state.themeMode,
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'Todos',
            theme: AppTheme.instance.light,
            darkTheme: AppTheme.instance.dark,
            themeMode: themeMode,
            initialRoute: "/",
            routes: routes,
            navigatorKey: navigatorKey,
            scaffoldMessengerKey: scaffoldMessengerKey,
          );
        },
      ),
    );
  }
}
