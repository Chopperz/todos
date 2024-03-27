part of 'home_bloc.dart';

@immutable
final class HomeState extends Equatable {
  final NetworkStatus status;
  final List<String> categories;

  const HomeState({
    this.status = NetworkStatus.init,
    this.categories = const <String>[],
  });

  factory HomeState.init() => HomeState(
        status: NetworkStatus.init,
      );

  HomeState copyWith({
    NetworkStatus? status,
    List<String>? categories,
  }) {
    return HomeState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [
        status,
        categories,
      ];
}
