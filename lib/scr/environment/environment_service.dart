import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../base/app_store_interface.dart';
import '../base/disposable/ttt_service.dart';
import 'environment_mixin.dart';

abstract class SharedConstants {
  static const String ASSET_PATH = "assets";
  static final String LOCALE_PATH = join(ASSET_PATH, "locales");
}

class EnvironmentService extends TttService implements EnvironmentMixin {
  static final EnvironmentService instance = EnvironmentService._();

  EnvironmentService._();

  final Map<String, dynamic> _shareVariable = {};

  void addSharedVariable(Map<String, dynamic> variable) {
    _shareVariable.addAll(variable);
  }

  void setVariable<T>(String variableKey, T value) {
    _shareVariable[variableKey] = value;
  }

  T getVariable<T>(
    String variableKey, {
    required T defaultValue,
  }) {
    var value = _shareVariable[variableKey];
    if (value is T) {
      return value;
    }

    return defaultValue;
  }

  @override
  ActiveProfile get activeProfile =>
      getVariable("activeProfile", defaultValue: ActiveProfile.dev);

  @override
  bool get enabledAds => getVariable("enabledAds", defaultValue: false);

  @override
  bool get isFullAds => getVariable("isFullAds", defaultValue: false);

  @override
  bool? get fixedIsFullAds => getVariable("fixedIsFullAds", defaultValue: null);

  @override
  set isFullAds(bool isFullAds) {
    setVariable("isFullAds", isFullAds);
  }

  @override
  RouterConfig<Object>? get router => getVariable("router", defaultValue: null);

  @override
  InitPriority get initPriority => InitPriority.ON_SPLASH;
}
