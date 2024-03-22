import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos_by_bloc/core/enums/enums.dart';
import 'package:todos_by_bloc/core/repositories/repositories.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {
    on<FetchUserEvent>(mapUserToState);
  }

  Future<void> mapUserToState(FetchUserEvent event, Emitter<UserState> emit) async {
    await UserRepository().getMe();
  }
}
