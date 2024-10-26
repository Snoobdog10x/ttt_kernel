part of '../app_store.dart';

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
  ActiveProfile get activeProfile => getVariable(
        SupportedVariable.activeProfile.name,
        defaultValue: ActiveProfile.dev,
      );

  @override
  List<GoRoute> get routers => getVariable(
        SupportedVariable.routers.name,
        defaultValue: [],
      );

  @override
  InitPriority get initPriority => InitPriority.ON_START_UP;

  @override
  FirebaseOptions? get firebaseOptions => getVariable(
        SupportedVariable.firebaseOptions.name,
        defaultValue: null,
      );
}
