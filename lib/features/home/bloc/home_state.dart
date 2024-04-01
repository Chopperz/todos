part of 'home_bloc.dart';

@immutable
final class HomeState extends Equatable {
  final HomeBlocStatus status;
  final List<String> categories;
  final List<ProductModel> topSelling;

  const HomeState({
    this.status = const HomeBlocStatus.init(),
    this.categories = const <String>[],
    this.topSelling = const <ProductModel>[],
  });

  factory HomeState.init() => HomeState(
        status: const HomeBlocStatus.init(),
      );

  HomeState copyWith({
    HomeBlocStatus? status,
    List<String>? categories,
    List<ProductModel>? topSelling,
  }) {
    return HomeState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      topSelling: topSelling ?? this.topSelling,
    );
  }

  @override
  List<Object?> get props => [
        status,
        categories,
        topSelling,
      ];
}
