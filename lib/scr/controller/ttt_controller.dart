library ttt_controller;

import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import '../base/app_store.dart';
import '../di/app_store_di_extension.dart';
import '../event_bus/event_bus_service.dart';
import '../stream/ttt_stream.dart';

part 'binding.dart';
part 'ttt_controller_provider.dart';
part 'ttt_multiple_controller_provider.dart';
part 'ttt_view.dart';

abstract class TttController extends State<TttControllerProvider>
    with LoggerMixin, Disposable, AutomaticKeepAliveClientMixin {
  @protected
  @mustCallSuper
  @override
  void initState() {
    logInfo("Init ${runtimeType.toString()}");
    AppStore.registerByRuntimeType(this, tag: widget.tag);
    super.initState();
    onInit();

    if (this is Bloc) {
      (this as Bloc).listenEvents();
    }

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      onReady();
    });
  }

  @protected
  void onReady() {}

  @protected
  @mustCallSuper
  @override
  void dispose() {
    super.dispose();
    logInfo("Dispose ${runtimeType.toString()}");

    if (this is Bloc) {
      (this as Bloc).disposeSubscriptions();
    }

    AppStore.removeByRuntimeType(runtimeType, tag: widget.tag);
    onDispose();
  }

  @protected
  @override
  void didUpdateWidget(covariant TttControllerProvider oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.tag == oldWidget.tag) {
      return;
    }

    AppStore.removeByRuntimeType(runtimeType, tag: oldWidget.tag);
    AppStore.registerByRuntimeType(this, tag: widget.tag);
  }

  @protected
  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.viewBuilder();
  }

  @protected
  void forceTreeRefresh() {
    if (!mounted) {
      return;
    }

    setState(() {});
  }

  @protected
  @override
  bool get wantKeepAlive => false;

  @protected
  @override
  void onInit() {}

  @protected
  @override
  void onDispose() {}
}
