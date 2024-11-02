part of 'ttt_storage.dart';

class LocalStorageService extends TttService with Bloc {
  static final LocalStorageService instance = LocalStorageService._();

  LocalStorageService._();

  late final SharedPreferences _sharedPreferences;

  @override
  Future<void> onDispose() async {}

  @override
  Future<void> onInit() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<StorageOperator?> _setCache<T>(String key, T value) async {
    if (value == null) {
      return null;
    }

    var operator = StorageOperator.CREATE;
    if (containsKey(key)) {
      operator = StorageOperator.UPDATE;
    }

    if (value is String) {
      await _sharedPreferences.setString(key, value);
      return operator;
    }

    if (value is bool) {
      await _sharedPreferences.setBool(key, value);
      return operator;
    }

    if (value is int) {
      await _sharedPreferences.setInt(key, value);
      return operator;
    }

    if (value is double) {
      await _sharedPreferences.setDouble(key, value);
      return operator;
    }

    if (value is List<String>) {
      await _sharedPreferences.setStringList(key, value);
      return operator;
    }

    if (value is Iterable<String>) {
      await _sharedPreferences.setStringList(key, value.toList());
      return operator;
    }

    return null;
  }

  Future<void> setCache<T extends Object?>(String key, T value) async {
    final operator = await _setCache(key, value);
    if (operator == null) {
      return;
    }

    var event = StorageEvent<T>(key: key, value: value, operator: operator);
    emit(event);
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
    var event = StorageEvent<Object?>(
      key: key,
      value: null,
      operator: StorageOperator.DELETE,
    );
    emit(event);
  }

  bool containsKey(String key) {
    return _sharedPreferences.containsKey(key);
  }

  Future<void> clearCache() async {
    var keys = _sharedPreferences.getKeys();
    await _sharedPreferences.clear();
    for (var key in keys) {
      var event = StorageEvent<Object?>(
        key: key,
        value: null,
        operator: StorageOperator.DELETE,
      );
      emit(event);
    }
  }
}
