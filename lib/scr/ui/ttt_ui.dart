library ttt_ui;

import 'package:flutter/material.dart';

import '../base/ttt_base.dart';
import '../stream/ttt_stream.dart';

_TttUi TttUi = _TttUi();

abstract class TttUiInterface {}

class _TttUi extends TttUiInterface {
  final TttStream<ThemeData> _currentTheme = TttStream(ThemeData.light());
  final TttStream<ThemeMode> _themeMode = TttStream(ThemeMode.system);

  ThemeData get currentTheme => _currentTheme.value;

  ThemeMode get themeMode => _themeMode.value;

  set themeMode(ThemeMode themeMode) {
    _themeMode.value = themeMode;

    if (!AppStore.initialized) {
      return;
    }
    AppStore.forceAppRebuild();
  }

  set currentTheme(ThemeData themeData) {
    _currentTheme.value = themeData;

    if (!AppStore.initialized) {
      return;
    }
    AppStore.forceAppRebuild();
  }
}

extension TttUiExtension on AppStoreInterface {
  _TttUi get tttUi => TttUi;
}
