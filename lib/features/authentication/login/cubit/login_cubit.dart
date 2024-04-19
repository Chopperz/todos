import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_by_bloc/core/enums/enums.dart';
import 'package:todos_by_bloc/core/repositories/repositories.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.context) : super(const LoginState());

  final BuildContext context;
  final AuthRepository repository = AuthRepository();

  void onPasswordChanged(String password) {
    //
  }

  void onLogin({required String username, required String password}) async {
    emit(state.copyWith(status: NetworkStatus.processing));

    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: username, password: password);

      if (userCredential.user == null) {
        emit(state.copyWith(status: NetworkStatus.error));
      } else {
        await repository.userLogIn();
        emit(state.copyWith(status: NetworkStatus.success));
      }
    } on FirebaseAuthException catch (fireErr) {
      print(fireErr.message);
      print(fireErr.code);
      emit(state.copyWith(status: NetworkStatus.error));
      rethrow;
    } catch (err) {
      throw err;
    }

    emit(state.copyWith(status: NetworkStatus.done));
  }
}
