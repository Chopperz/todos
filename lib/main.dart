import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todos_by_bloc/core/providers/user_bloc/user_bloc.dart';
import 'package:todos_by_bloc/core/services/dio/dio_service.dart';

import 'config/router/router.dart';

late String appDirectoryPath;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getTemporaryDirectory();
  appDirectoryPath = dir.path;
  HydratedBloc.storage = await HydratedStorage.build(storageDirectory: dir);
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
          create: (context) => UserBloc(),
          lazy: false,
        )
      ],
      child: MaterialApp(
        title: 'Todo List',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
          useMaterial3: true,
        ),
        initialRoute: "/",
        routes: routes,
        navigatorKey: navigatorKey,
      ),
    );
  }
}
