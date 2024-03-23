import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_by_bloc/core/models/models.dart';
import 'package:todos_by_bloc/features/authentication/authentication.dart';
import 'package:todos_by_bloc/features/authentication/login/cubit/login_cubit.dart';
import 'package:todos_by_bloc/features/home/bloc/home_bloc.dart';
import 'package:todos_by_bloc/features/home/screen/home_screen.dart';
import 'package:todos_by_bloc/features/settings/screen/settings_screen.dart';

export 'package:todos_by_bloc/config/router/router.dart';

/* Arguments */
part 'src/arguments/home_arguments.dart';

/* Routes */
part 'src/routes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();