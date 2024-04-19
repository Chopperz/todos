import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_by_bloc/features/authentication/authentication.dart';
import 'package:todos_by_bloc/features/home/screen/home_screen.dart';
import 'package:todos_by_bloc/features/settings/screen/settings_screen.dart';

export 'package:todos_by_bloc/config/router/router.dart';

/* Arguments */
part 'src/arguments/home_arguments.dart';

/* Routes */
part 'src/routes.dart';

enum AppRouter {
  home,
  login,
  register,
  settings,
}

extension _AppRouterExtension on AppRouter {
  String get routeName {
    switch(this) {
      case AppRouter.home:
        return "/";
      case AppRouter.login:
        return "/login";
      case AppRouter.register:
        return "/register";
      case AppRouter.settings:
        return "/settings";
      default:
        return "/error-page";
    }
  }
}