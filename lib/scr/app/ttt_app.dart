import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../base/app_service_initializer_extension.dart';
import '../base/app_store.dart';
import '../base/disposable/ttt_service.dart';
import '../environment/app_store_environment_extension.dart';
import '../locale/locale_service.dart';
import '../stream/watcher.dart';

class TttApp extends StatefulWidget {
  final Map<String, dynamic> sharedVariables;

  const TttApp({
    super.key,
    required this.sharedVariables,
  });

  @override
  State<TttApp> createState() => TttAppState();
}

class TttAppState<T extends TttApp> extends State<T> {
  @override
  void initState() {
    super.initState();
    AppStore.environmentService.addSharedVariable(widget.sharedVariables);
    initApp();
  }

  Future<void> initApp() async {
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
          routerConfig: AppStore.router,
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
