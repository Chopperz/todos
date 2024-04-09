part of 'user_bloc.dart';

@immutable
sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

final class FetchUserEvent extends UserEvent {
  const FetchUserEvent();
}

final class UserLogoutEvent extends UserEvent {
  const UserLogoutEvent();
}
