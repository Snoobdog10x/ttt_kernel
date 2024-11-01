library ttt_di;

import '../base/ttt_base.dart';

final Map<String, dynamic> _instanceMap = {};

extension AppStoreDiExtension on AppStoreInterface {
  String _buildKey(Type type, {String? tag}) {
    return "${type.toString()}_$tag";
  }

  void _registerInstance<T>(
    dynamic instance, {
    String? tag,
    bool byRuntimeType = false,
  }) {
    var type = T;
    if (byRuntimeType) {
      type = instance.runtimeType;
    }

    var key = _buildKey(type, tag: tag);
    _instanceMap[key] = instance;
  }

  void remove<T>({String? tag}) {
    var key = _buildKey(T, tag: tag);
    _instanceMap.remove(key);
  }

  void removeByRuntimeType(Type runtimeType, {String? tag}) {
    var key = _buildKey(runtimeType, tag: tag);
    _instanceMap.remove(key);
  }

  T find<T>({String? tag}) {
    var key = _buildKey(T, tag: tag);
    if (!_instanceMap.containsKey(key)) {
      throw Exception(
        "Not found ${T.runtimeType.toString()}, make sure you have register or lazyRegister its",
      );
    }

    var instance = _instanceMap[key];
    if (instance is T) {
      return instance;
    }

    if (instance is! T Function()) {
      throw Exception("Un catch exception");
    }

    instance = instance();
    _instanceMap[key] = instance;
    return instance;
  }

  void lazyRegister<T>(T Function() instanceBuilder, {String? tag}) =>
      _registerInstance<T>(
        instanceBuilder,
        tag: tag,
      );

  void register<T>(T instance, {String? tag}) =>
      _registerInstance<T>(instance, tag: tag);

  void registerByRuntimeType<T>(T instance, {String? tag}) =>
      _registerInstance(instance, tag: tag, byRuntimeType: true);
}
