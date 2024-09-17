part of '../app_configs.dart';

enum EnvironmentConfig { init, development, production }

extension EnvironmentConfigExtension on EnvironmentConfig {
  bool get isDev => this == EnvironmentConfig.development;

  bool get isProd => this == EnvironmentConfig.production;
}