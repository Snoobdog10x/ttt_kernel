library ttt_app;

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import '../base/app_store.dart';
import '../locale/locale_service.dart';
import '../stream/ttt_stream.dart';

part 'firebase_remote_service.dart';
part 'firebase_service.dart';
part 'route_appstore_extension.dart';

class TttApp extends StatefulWidget {
  final Map<String, dynamic> sharedVariables;

  const TttApp({
    super.key,
    required this.sharedVariables,
  });

  @override
  State<TttApp> createState() => TttAppState();
}

class TttAppState<T extends TttApp> extends State<T> with LoggerMixin {
  @override
  void initState() {
    super.initState();
    AppStore.environmentService.addSharedVariable(widget.sharedVariables);
    _initApp();
  }

  Future<void> _initApp() async {
    await AppStore.startUp();
    setState(() {});
  }

  ThemeData? get themeData => null;

  ThemeMode? get themeMode => null;

  @override
  Widget build(BuildContext context) {
    if (AppStore.initState == InitPriority.ON_START_UP) {
      return const SizedBox();
    }

    return Watcher(
      () {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: GoRouter(
            navigatorKey: AppStore.navigatorKey,
            routes: AppStore.routers,
            observers: [AppStore.firebaseAnalyticsObserver],
          ),
          locale: LocaleService.instance.currentLocale.value,
          supportedLocales: LocaleService.instance.supportedLocales,
          theme: themeData,
          themeMode: themeMode,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      },
    );
  }
}
