import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_by_bloc/config/firebase/app_firebase.dart';
import 'package:todos_by_bloc/core/enums/enums.dart';
import 'package:todos_by_bloc/core/extensions/extensions.dart';
import 'package:todos_by_bloc/core/models/src/user/user_model.dart';
import 'package:uuid/uuid.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());

  void onEmailChanged(String value) {
    String? errorText;

    if (value.isNotEmpty && !AppRegExp.isEmail.regExp.hasMatch(value)) {
      errorText = "Email is invalid.";
    }

    emit(state.copyWith(
      email: value,
      errorText: errorText ?? "",
    ));
  }

  void onPasswordChanged(String value) => emit(state.copyWith(password: value));

  void onFirstNameChanged(String value) {
    final user = state.user.copyWith(firstName: value);
    emit(state.copyWith(user: user));
  }

  void onLastNameChanged(String value) {
    final user = state.user.copyWith(lastName: value);
    emit(state.copyWith(user: user));
  }

  void onNickNameChanged(String value) {
    final user = state.user.copyWith(nickName: value);
    emit(state.copyWith(user: user));
  }

  void onDateOfBirth(String value) {
    final user = state.user.copyWith(dateOfBirth: value);
    emit(state.copyWith(user: user));
  }

  Future<void> onSubmitRegister() async {
    emit(state.copyWith(status: NetworkStatus.processing));
    bool isUserAvailable =
        await AppFirebase.instance.signUpWithEmailAndPassword(state.email, state.password);
    if (isUserAvailable) {
      DatabaseReference ref = AppFirebase.instance.database(path: "users");
      await ref.update({
        Uuid().v1(): state.user.toJson(),
      });

      emit(state.copyWith(status: NetworkStatus.success));
    } else {
      emit(state.copyWith(status: NetworkStatus.error));
      await Future.delayed(const Duration(seconds: 1));
    }
    emit(state.copyWith(status: NetworkStatus.done));
  }
}
