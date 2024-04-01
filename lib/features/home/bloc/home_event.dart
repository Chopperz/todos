part of 'home_bloc.dart';

@immutable
sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

final class FetchCategoriesEvent extends HomeEvent {
  const FetchCategoriesEvent();
}

final class FetchTopSellingEvent extends HomeEvent {
  const FetchTopSellingEvent();
}
