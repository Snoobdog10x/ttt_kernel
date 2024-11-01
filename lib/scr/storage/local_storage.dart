import 'package:shared_preferences/shared_preferences.dart';

import '../base/ttt_base.dart';

class LocalStorageService extends TttService {
  static final LocalStorageService instance = LocalStorageService._();

  LocalStorageService._();

  late final SharedPreferences _sharedPreferences;

  @override
  Future<void> onDispose() async {}

  @override
  Future<void> onInit() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> setCache<T extends Object?>(String key, T value) async {
    if (value == null) {
      logError("Key $key is trying to set null value!");
      return;
    }

    if (value is String) {
      await _sharedPreferences.setString(key, value);
      return;
    }

    if (value is bool) {
      await _sharedPreferences.setBool(key, value);
      return;
    }

    if (value is int) {
      await _sharedPreferences.setInt(key, value);
      return;
    }

    if (value is double) {
      await _sharedPreferences.setDouble(key, value);
      return;
    }

    if (value is List<String>) {
      await _sharedPreferences.setStringList(key, value);
      return;
    }

    if (value is Iterable<String>) {
      await _sharedPreferences.setStringList(key, value.toList());
      return;
    }

    logError("Not support type ${T.runtimeType.toString()}");
  }

  T? getCache<T extends Object?>(String key) {
    return _sharedPreferences.get(key) as T?;
  }

  String getString(String key) {
    return _sharedPreferences.getString(key) ?? "";
  }

  int getInt(String key) {
    return _sharedPreferences.getInt(key) ?? 0;
  }

  double getDouble(String key) {
    return _sharedPreferences.getDouble(key) ?? 0.0;
  }

  bool getBool(String key) {
    return _sharedPreferences.getBool(key) ?? false;
  }

  List<String> getStringList(String key) {
    return _sharedPreferences.getStringList(key) ?? [];
  }

  Future<void> removeCache(String key) async {
    await _sharedPreferences.remove(key);
  }

  bool containsKey(String key) {
    return _sharedPreferences.containsKey(key);
  }

  Future<void> clearCache() async {
    await _sharedPreferences.clear();
  }
}
