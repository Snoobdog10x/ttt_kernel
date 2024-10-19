import 'package:flutter/widgets.dart';

import '../base/app_store_interface.dart';
import 'environment_service.dart';

mixin EnvironmentMixin {
  bool get enabledAds => EnvironmentService.instance.enabledAds;

  bool get isFullAds => EnvironmentService.instance.isFullAds;

  set isFullAds(bool isFullAds) {
    EnvironmentService.instance.isFullAds = isFullAds;
  }

  ActiveProfile get activeProfile => EnvironmentService.instance.activeProfile;

  bool? get fixedIsFullAds => EnvironmentService.instance.fixedIsFullAds;

  RouterConfig<Object>? get router => EnvironmentService.instance.router;
}
