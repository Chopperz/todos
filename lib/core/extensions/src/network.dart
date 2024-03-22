import 'package:todos_by_bloc/core/enums/src/network.dart';

extension NetworkStatusX on NetworkStatus {
  bool get isInit => this == NetworkStatus.init;

  bool get isProcessing => this == NetworkStatus.processing;

  bool get isSuccess => this == NetworkStatus.success;

  bool get isError => this == NetworkStatus.error;

  bool get isDone => this == NetworkStatus.done;
}
