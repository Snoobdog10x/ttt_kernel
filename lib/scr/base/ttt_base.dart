library ttt_base;

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart' as intl;
import 'package:path/path.dart' as p;
import 'package:responsive_framework/responsive_framework.dart';

import '../extension/ttt_extension.dart';
import '../firebase/firebase.dart';
import '../locale/locale_service.dart';
import '../storage/ttt_storage.dart';
import '../stream/ttt_stream.dart';
import '../ui/ttt_ui.dart';

part 'app_store_interface.dart';
part 'disposable/disposable.dart';
part 'disposable/ttt_service.dart';
part 'environment/app_store_environment_extension.dart';
part 'environment/environment_mixin.dart';
part 'environment/environment_service.dart';
part 'mixin/logger_mixin.dart';
part 'router/route_appstore_extension.dart';

AppStoreInterface get AppStore => _appStore;
late final AppStoreInterface _appStore;

abstract class TttApp extends StatefulWidget {
  final Map<String, dynamic> sharedVariables;

  const TttApp({
    super.key,
    required this.sharedVariables,
  });

  @override
  TttAppState createState();
}

abstract class TttAppState<T extends TttApp> extends State<T>
    with EnvironmentMixin, LoggerMixin, AppStoreInterface {
  final Completer _initializedCompleter = Completer();
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  late final GoRouter _router = GoRouter(
    navigatorKey: AppStore.navigatorKey,
    routes: AppStore.routers,
    observers: [],
  );

  @mustCallSuper
  @override
  void initState() {
    _appStore = this;
    environmentService.addSharedVariable(widget.sharedVariables);
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    await AppStore.localStorageService.initService();
    await AppStore.localeService.initService();
    await Firebase.initializeApp(options: AppStore.firebaseOptions);
    await AppStore.firebaseRemoteService.initService();
    await initServices();
    await 2.seconds.delay();
    _initializedCompleter.complete();
  }

  Future<void> initServices();

  Widget buildSplash() {
    return Container(
      color: Colors.black,
      child: const Text("Camera plus"),
    );
  }

  Size get designSize => ScreenUtil.defaultSize;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: designSize,
      child: FutureBuilder(
        future: _initializedCompleter.future,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            bool isRtl = intl.Bidi.isRtlLanguage(
                AppStore.localeService.currentLocale.languageCode);
            return Directionality(
              textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
              child: Material(
                child: buildSplash(),
              ),
            );
          }

          return ResponsiveBreakpoints(
            breakpoints: const [
              Breakpoint(start: 0, end: 450, name: MOBILE),
              Breakpoint(start: 451, end: 800, name: TABLET),
              Breakpoint(start: 801, end: 1920, name: DESKTOP),
              Breakpoint(start: 1921, end: double.infinity, name: '4K'),
            ],
            child: Watcher(
              () => MaterialApp.router(
                debugShowCheckedModeBanner: false,
                routerConfig: _router,
                locale: LocaleService.instance.currentLocale,
                supportedLocales: SupportedLocale.supportedLocales,
                theme: TttUi.currentTheme,
                themeMode: TttUi.themeMode,
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Future<void> forceAppRebuild() =>
      WidgetsBinding.instance.reassembleApplication();

  @override
  GoRouter get router => _router;

  @override
  Future get initialize => _initializedCompleter.future;

  @override
  bool get initialized => _initializedCompleter.isCompleted;

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  double get width => MediaQuery.sizeOf(context).width;

  @override
  double get height => MediaQuery.sizeOf(context).height;

  @override
  double get ratioPixel => MediaQuery.devicePixelRatioOf(context);
}
