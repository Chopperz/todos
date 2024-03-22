part of '../router.dart';

final Map<String, Widget Function(BuildContext)> routes = <String, Widget Function(BuildContext)>{
  "/": (context) => const HomeScreen(),
  "/login": (context) => BlocProvider(
        create: (context) => LoginCubit(),
        child: const LoginScreen(),
      ),
};
