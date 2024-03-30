import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_by_bloc/core/enums/enums.dart';
import 'package:todos_by_bloc/core/extensions/extensions.dart';
import 'package:todos_by_bloc/core/repositories/repositories.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.context) : super(const LoginState());

  final BuildContext context;
  final UserRepository repository = UserRepository();

  void onPasswordChanged(String password) {
    //
  }

  void onChangedRememberMe() {
    emit(state.copyWith(isRememberMe: !state.isRememberMe));
  }

  void onLogin({required String username, required String password}) async {
    emit(state.copyWith(status: NetworkStatus.processing));
    bool isLoggedIn = await repository.userLogIn(username: username, password: password);

    if (!isLoggedIn) {
      emit(state.copyWith(status: NetworkStatus.error));
      return;
    } else {
      if (state.isRememberMe) {
        context.localStorage.setBool("remember-me-key", true);
      }
      emit(state.copyWith(status: NetworkStatus.success));
    }

    emit(state.copyWith(status: NetworkStatus.done));
  }
}
