part of '../bloc/home_bloc.dart';

final class HomeBlocStatus {
  final NetworkStatus mainStatus;
  final NetworkStatus categoryStatus;
  final NetworkStatus topSellingStatus;

  const HomeBlocStatus({
    this.mainStatus = NetworkStatus.init,
    this.categoryStatus = NetworkStatus.init,
    this.topSellingStatus = NetworkStatus.init,
  });

  const factory HomeBlocStatus.init() = HomeBlocStatus;

  HomeBlocStatus copyWith({
    NetworkStatus? mainStatus,
    NetworkStatus? categoryStatus,
    NetworkStatus? topSellingStatus,
  }) {
    return HomeBlocStatus(
      mainStatus: mainStatus ?? this.mainStatus,
      categoryStatus: categoryStatus ?? this.categoryStatus,
      topSellingStatus: topSellingStatus ?? this.topSellingStatus,
    );
  }
}