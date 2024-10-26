part of '../app_store.dart';

mixin EnvironmentMixin {
  ActiveProfile get activeProfile => EnvironmentService.instance.activeProfile;

  FirebaseOptions? get firebaseOptions =>
      EnvironmentService.instance.firebaseOptions;

  List<GoRoute> get routers => EnvironmentService.instance.routers;
}
