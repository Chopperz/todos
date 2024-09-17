import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todos_by_bloc/config/l10n/l10n.dart';
import 'package:todos_by_bloc/core/providers/providers.dart';
import 'package:todos_by_bloc/theme/app_theme.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_by_bloc/core/services/dio/dio_service.dart';

import '../../core/constants/app_constants.dart';
import '../router/router.dart';

part 'src/environment_config.dart';

void appInitialization() async {
  final dir = await getTemporaryDirectory();
  appDirectoryPath = dir.path;
  HydratedBloc.storage = await HydratedStorage.build(storageDirectory: dir);
  sharedPreferences = await SharedPreferences.getInstance();
  await dotenv.load(fileName: ".env");
  await DioService.initialize();
  runApp(const MyAppConfigs());
}

class MyAppConfigs extends StatefulWidget {
  const MyAppConfigs({super.key});

  @override
  State<MyAppConfigs> createState() => _MyAppConfigsState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppConfigsState? state = context.findAncestorStateOfType<_MyAppConfigsState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppConfigsState extends State<MyAppConfigs> {
  EnvironmentConfig environment = EnvironmentConfig.init;
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    environment = EnvironmentConfig.values.byName(FlavorConfig.instance.variables["env"]);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc(context)..add(const FetchUserEvent()),
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
            debugShowCheckedModeBanner: false,
            theme: AppTheme.instance.light,
            darkTheme: AppTheme.instance.dark,
            themeMode: themeMode,
            initialRoute: "/",
            routes: routes,
            navigatorKey: navigatorKey,
            scaffoldMessengerKey: scaffoldMessengerKey,
            supportedLocales: L10n.all,
            locale: _locale,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            builder: (BuildContext context, Widget? child) {
              if (!environment.isProd) {
                return Banner(
                  message: FlavorConfig.instance.name ?? "DEV",
                  location: FlavorConfig.instance.location,
                  child: child!,
                );
              }

              return child!;
            },
          );
        },
      ),
    );
  }
}
