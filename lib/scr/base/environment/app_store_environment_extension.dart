part of '../app_store.dart';

enum SupportedVariable {
  activeProfile,
  routers,
  firebaseOptions,
}

extension AppStoreAppInfoExtension on AppStoreInterface {
  EnvironmentService get environmentService => EnvironmentService.instance;
}
