part of 'user_bloc.dart';

@immutable
class UserState extends Equatable {
  const UserState({
    this.authStatus = NetworkStatus.init,
    this.status = NetworkStatus.init,
    this.user,
  });

  factory UserState.logout() => UserState(
    authStatus: NetworkStatus.error,
    status: NetworkStatus.init,
  );

  final NetworkStatus authStatus;
  final NetworkStatus status;
  final UserModel? user;

  UserState copyWith({
    NetworkStatus? authStatus,
    NetworkStatus? status,
    UserModel? user,
  }) {
    return UserState(
      authStatus: authStatus ?? this.authStatus,
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        authStatus,
        status,
        user,
      ];
}
