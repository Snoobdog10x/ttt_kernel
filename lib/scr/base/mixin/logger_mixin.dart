import '../app_store.dart';
import '../app_store_interface.dart';

enum LogLevel {
  debug,
  info,
  warning,
  error,
}

mixin LoggerMixin {
  static const String reset = '\x1B[0m';
  static const String red = '\x1B[31m';
  static const String green = '\x1B[32m';
  static const String yellow = '\x1B[33m';
  static const String blue = '\x1B[34m';
  static const String magenta = '\x1B[35m';
  static const String cyan = '\x1B[36m';
  static const String white = '\x1B[37m';

  void _logMessage({
    required LogLevel logLevel,
    required String message,
  }) {
    if (AppStore.activeProfile == ActiveProfile.production) {
      return;
    }

    var logLevelColor = green;
    if (logLevel == LogLevel.error) {
      logLevelColor = red;
    }

    if (logLevel == LogLevel.warning) {
      logLevelColor = yellow;
    }

    var actuallyMessage =
        "$logLevelColor[${logLevel.name.toUpperCase()}]$reset $magenta[${getLoggerSource()}]$reset $message";
    var appName = "Alphalogy";

    print("[$appName] $actuallyMessage");
  }

  String getLoggerSource() => runtimeType.toString();

  void logInfo(String message) {
    _logMessage(logLevel: LogLevel.info, message: message);
  }

  void logDebug(String message) {
    _logMessage(logLevel: LogLevel.debug, message: message);
  }

  void logWarning(String message) {
    _logMessage(logLevel: LogLevel.warning, message: message);
  }

  void logError(String message) {
    _logMessage(logLevel: LogLevel.error, message: message);
  }
}
