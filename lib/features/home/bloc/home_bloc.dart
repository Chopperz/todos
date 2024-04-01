import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todos_by_bloc/core/enums/enums.dart';
import 'package:todos_by_bloc/core/models/models.dart';
import 'package:todos_by_bloc/core/repositories/repositories.dart';
import 'package:todos_by_bloc/core/services/dio/dio_service.dart';

part 'home_event.dart';

part 'home_state.dart';

part '../models/home_bloc_status.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<FetchCategoriesEvent>(mapCategoriesToState);
    on<FetchTopSellingEvent>(mapTopSellingToState);
  }

  final HomeRepository repository = HomeRepository();

  Future<void> mapCategoriesToState(FetchCategoriesEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(
      status: state.status.copyWith(categoryStatus: NetworkStatus.processing),
    ));

    List<dynamic>? categories = await repository.getCategories();

    if (categories != null) {
      emit(state.copyWith(
        categories: List.castFrom<dynamic, String>(categories),
        status: state.status.copyWith(categoryStatus: NetworkStatus.success),
      ));
    } else {
      emit(state.copyWith(
        status: state.status.copyWith(categoryStatus: NetworkStatus.error),
      ));
    }

    emit(state.copyWith(
      status: state.status.copyWith(categoryStatus: NetworkStatus.done),
    ));
  }

  Future<void> mapTopSellingToState(FetchTopSellingEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(
      status: state.status.copyWith(topSellingStatus: NetworkStatus.processing),
    ));
    final res = await DioService().get("/products/category/tops");

    if (res.isSuccess) {
      List data = res.data["products"] as List;
      List<ProductModel> products = data.map((json) => ProductModel.fromJson(json)).toList();
      emit(state.copyWith(topSelling: products));
    }

    emit(state.copyWith(
      status: state.status.copyWith(topSellingStatus: NetworkStatus.done),
    ));
  }
}
