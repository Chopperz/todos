part of 'login_cubit.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.status = NetworkStatus.init,
    this.isRememberMe = false,
    this.errorText,
  });

  final NetworkStatus status;
  final bool isRememberMe;
  final String? errorText;

  LoginState copyWith({
    NetworkStatus? status,
    bool? isRememberMe,
    String? errorText,
  }) {
    return LoginState(
      status: status ?? this.status,
      isRememberMe: isRememberMe ?? this.isRememberMe,
      errorText: errorText ?? this.errorText,
    );
  }

  @override
  List<Object?> get props => [
    status,
    isRememberMe,
    errorText,
  ];
}
