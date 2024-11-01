library ttt_ui;

import 'package:flutter/material.dart';

import '../base/ttt_base.dart';
import '../stream/ttt_stream.dart';

final TttStream<ThemeData> _currentTheme = TttStream(ThemeData.light());

extension TttUi on AppStoreInterface {
  ThemeData get currentTheme => _currentTheme.value;

  set currentTheme(ThemeData themeData) => _currentTheme.value;
}
