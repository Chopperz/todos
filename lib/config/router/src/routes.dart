part of '../router.dart';

final Map<String, Widget Function(BuildContext)> routes = <String, Widget Function(BuildContext)>{
  AppRouter.home.routeName: (context) => const HomeScreen(),
  AppRouter.login.routeName: (context) => BlocProvider<LoginCubit>(
        create: (context) => LoginCubit(context),
        child: const LoginScreen(),
      ),
  AppRouter.register.routeName: (context) => BlocProvider<RegisterCubit>(
        create: (context) => RegisterCubit(),
        child: const RegisterScreen(),
      ),
  AppRouter.settings.routeName: (context) => const SettingsScreen(),
};
