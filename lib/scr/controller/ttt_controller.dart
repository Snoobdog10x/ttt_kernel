import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import '../../ttt_kernel.dart';
import '../base/mixin/logger_mixin.dart';
import '../event_bus/bloc.dart';
import 'ttt_controller_provider.dart';

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

  void forceTreeRefresh() {
    if (!mounted) {
      return;
    }

    setState(() {});
  }

  @protected
  @override
  bool get wantKeepAlive => false;

  @override
  void onInit() {}

  @override
  void onDispose() {}
}
