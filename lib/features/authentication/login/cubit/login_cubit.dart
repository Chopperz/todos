import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_by_bloc/core/enums/enums.dart';
import 'package:todos_by_bloc/core/repositories/repositories.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  final UserRepository repository = UserRepository();

  void onPasswordChanged(String password) {
    //
  }

  void onLogin({required String username, required String password}) async {
    emit(state.copyWith(status: NetworkStatus.processing));
    bool isLoggedIn = await repository.userLogIn(username: username, password: password);

    if (!isLoggedIn) {
      emit(state.copyWith(status: NetworkStatus.error));
      return;
    } else {
      emit(state.copyWith(status: NetworkStatus.success));
    }

    emit(state.copyWith(status: NetworkStatus.done));
  }
}
