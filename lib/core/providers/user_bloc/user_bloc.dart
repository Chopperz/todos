import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_by_bloc/core/enums/enums.dart';
import 'package:todos_by_bloc/core/extensions/extensions.dart';
import 'package:todos_by_bloc/core/models/src/user/user_model.dart';
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
  }

  final BuildContext context;

  Future<void> mapUserToState(FetchUserEvent event, Emitter<UserState> emit) async {
    if (state.authStatus.isInit) FlutterNativeSplash.remove();

    emit(state.copyWith(authStatus: NetworkStatus.processing));

    final res = await UserRepository().getMe();

    if (res.data["message"] == "Invalid/Expired Token!") {
      emit(state.copyWith(authStatus: NetworkStatus.error));
    } else {
      emit(state.copyWith(
        user: UserModel.fromJson(res.data),
        status: NetworkStatus.success,
      ));
    }

    emit(state.copyWith(authStatus: NetworkStatus.done));
  }

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
}
