library ttt_storage;

import 'package:shared_preferences/shared_preferences.dart';

import '../base/ttt_base.dart';
import '../event_bus/event_bus_service.dart';

part 'local_storage_storage.dart';
part 'storage_event.dart';

extension LocalStorageExtension on AppStoreInterface {
  LocalStorageService get localStorageService => LocalStorageService.instance;
}
