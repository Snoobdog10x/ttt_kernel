library ttt_storage;

import '../base/ttt_base.dart';
import 'local_storage.dart';

extension LocalStorageExtension on AppStoreInterface {
  LocalStorageService get localStorageService => LocalStorageService.instance;
}
