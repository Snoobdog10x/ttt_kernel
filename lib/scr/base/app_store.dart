import '../../ttt_kernel.dart';

_AppStore get AppStore => _AppStore.instance;

class _AppStore extends AppStoreInterface {
  static final _AppStore instance = _AppStore();
}
