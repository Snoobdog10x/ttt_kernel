part of '../ttt_base.dart';

enum SupportedVariable {
  activeProfile,
  routers,
  firebaseOptions,
}

extension AppStoreAppInfoExtension on AppStoreInterface {
  EnvironmentService get environmentService => EnvironmentService.instance;
}
