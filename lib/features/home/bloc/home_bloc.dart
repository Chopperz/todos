import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todos_by_bloc/core/enums/enums.dart';
import 'package:todos_by_bloc/core/repositories/repositories.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<FetchCategoriesEvent>(mapCategoriesToState);
  }

  final HomeRepository repository = HomeRepository();

  Future<void> mapCategoriesToState(FetchCategoriesEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: NetworkStatus.processing));

    List<dynamic>? categories = await repository.getCategories();

    if (categories != null) {
      emit(state.copyWith(
        categories: List.castFrom<dynamic, String>(categories),
        status: NetworkStatus.success,
      ));
    } else {
      emit(state.copyWith(status: NetworkStatus.error));
    }

    emit(state.copyWith(status: NetworkStatus.done));
  }
}
