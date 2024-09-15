part of 'register_cubit.dart';

final class RegisterState extends Equatable {
  final NetworkStatus status;
  final String email;
  final String password;
  final UserModel user;
  final String? errorText;

  const RegisterState({
    this.status = NetworkStatus.init,
    this.email = "",
    this.password = "",
    this.user = const UserModel(),
    this.errorText,
  });

  RegisterState copyWith({
    NetworkStatus? status,
    String? email,
    String? password,
    UserModel? user,
    String? errorText,
  }) {
    return RegisterState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      user: user ?? this.user,
      errorText: errorText ?? this.errorText,
    );
  }

  bool get isAvailableRegister =>
      email.isNotEmpty &&
      !errorText.isNotEmptyOrNull &&
      password.isNotEmpty &&
      user.firstName.isNotEmptyOrNull &&
      user.lastName.isNotEmptyOrNull &&
      user.dateOfBirth.isNotEmptyOrNull;

  @override
  List<Object?> get props => [
        status,
        email,
        password,
        user,
        errorText,
      ];
}
