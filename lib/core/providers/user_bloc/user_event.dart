part of 'user_bloc.dart';

sealed class UserEvent with EquatableMixin {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

final class FetchUserEvent extends UserEvent {
  const FetchUserEvent();
}
