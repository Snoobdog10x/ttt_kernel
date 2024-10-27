library ttt_appstore;

import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';

part 'app_service_initializer_extension.dart';
part 'app_store_interface.dart';
part 'disposable/disposable.dart';
part 'disposable/ttt_service.dart';
part 'environment/app_store_environment_extension.dart';
part 'environment/environment_mixin.dart';
part 'environment/environment_service.dart';
part 'mixin/logger_mixin.dart';

_AppStore get AppStore => _AppStore.instance;

class _AppStore extends AppStoreInterface {
  static final _AppStore instance = _AppStore();
}
