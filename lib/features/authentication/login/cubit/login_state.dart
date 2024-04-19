part of 'login_cubit.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.status = NetworkStatus.init,
    this.errorText,
  });

  final NetworkStatus status;
  final String? errorText;

  LoginState copyWith({
    NetworkStatus? status,
    bool? isRememberMe,
    String? errorText,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorText,
  ];
}
