import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_by_bloc/core/constants/app_constants.dart';
import 'package:todos_by_bloc/core/enums/enums.dart';
import 'package:todos_by_bloc/core/extensions/extensions.dart';
import 'package:todos_by_bloc/core/models/src/user/user_model.dart';
import 'package:todos_by_bloc/core/providers/providers.dart';
import 'package:todos_by_bloc/core/repositories/repositories.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends HydratedBloc<UserEvent, UserState> {
  UserBloc(this.context) : super(UserState()) {
    on<FetchUserEvent>(
      mapUserToState,
      transformer: (events, mapper) =>
          events.debounceTime(const Duration(milliseconds: 200)).asyncExpand(mapper),
    );
    on<UserLogoutEvent>(removeUserOnState);
  }

  final BuildContext context;
  final UserRepository userRepository = UserRepository();
  final AuthRepository authRepository = AuthRepository();

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    return UserState(
      user: UserModel.fromJson(json["userKey"]),
    );
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    return {
      "userKey": state.user?.toJson(),
    };
  }

  Future<void> mapUserToState(FetchUserEvent event, Emitter<UserState> emit) async {
    if (state.authStatus.isInit) FlutterNativeSplash.remove();

    if (!state.authStatus.isProcessing) emit(state.copyWith(authStatus: NetworkStatus.processing));

    final res = await userRepository.getMe();

    String message = res.data["message"] ?? "";

    if (["Token", "Expired"].any(message.contains)) {
      emit(state.copyWith(authStatus: NetworkStatus.error));
    } else {
      emit(state.copyWith(
        user: UserModel.fromJson(res.data),
        status: NetworkStatus.success,
      ));
      emit(state.copyWith(authStatus: NetworkStatus.done));
    }
  }

  Future<void> removeUserOnState(UserLogoutEvent event, Emitter<UserState> emit) async {
    await authRepository.userLogout();
    await clear();
    navigatorKey.currentState?.popUntil((route) => route.isFirst);
    emit(UserState.logout());
  }
}
