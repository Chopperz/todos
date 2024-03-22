part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState({
    this.status = NetworkStatus.init,
  });

  final NetworkStatus status;

  UserState copyWith({
    NetworkStatus? status,
  }) {
    return UserState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        status,
      ];
}
