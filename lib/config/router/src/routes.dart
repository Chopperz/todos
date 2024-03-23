part of '../router.dart';

final Map<String, Widget Function(BuildContext)> routes = <String, Widget Function(BuildContext)>{
  "/": (context) => BlocProvider(
        create: (context) => HomeBloc(),
        child: const HomeScreen(),
      ),
  "/login": (context) => BlocProvider(
        create: (context) => LoginCubit(),
        child: const LoginScreen(),
      ),
  "/settings": (context) => const SettingsScreen(),
};
