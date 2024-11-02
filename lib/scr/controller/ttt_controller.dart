library ttt_controller;

import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import '../base/ttt_base.dart';
import '../stream/ttt_stream.dart';

part 'binding.dart';
part 'ttt_controller_provider.dart';
part 'ttt_multiple_controller_provider.dart';
part 'ttt_view.dart';

abstract class TttController extends State<TttControllerProvider>
    with LoggerMixin, Disposable, AutomaticKeepAliveClientMixin {
  late _BindingWidgetState _rootState;

  @protected
  @mustCallSuper
  @override
  void initState() {
    super.initState();
    logInfo("Init ${runtimeType.toString()}");
    onInit();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      onReady();
    });
  }

  @override
  void didChangeDependencies() {
    _rootState = context.rootState;
    _rootState.putController(this);
    super.didChangeDependencies();
  }

  @protected
  void onReady() {}

  @protected
  @mustCallSuper
  @override
  void dispose() {
    _rootState.deleteController(this);
    super.dispose();
    logInfo("Dispose ${runtimeType.toString()}");
    onDispose();
  }

  @protected
  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.view;
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
