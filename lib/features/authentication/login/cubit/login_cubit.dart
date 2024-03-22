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
    await repository.userLogIn(username: username, password: password);
    final res = await repository.getMe();

    if (res.statusCode == 200 && res.data != null) {
      emit(state.copyWith(status: NetworkStatus.success));
    } else {
      emit(state.copyWith(status: NetworkStatus.error));
    }
  }
}
