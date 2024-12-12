part of "ttt_controller.dart";

typedef ControllerBuilder<T> = Widget Function(T controller);
typedef WatcherBuilder = Widget Function();

abstract class TttView<T extends TttController> extends StatelessWidget
    with LoggerMixin {
  const TttView({super.key});

  @override
  Widget build(BuildContext context) => buildView(
        context,
        context.findController<T>(),
      );

  Widget buildView(BuildContext context, T controller);

  ControlBuilder<T> buildControl(ControllerBuilder<T> builder) {
    return ControlBuilder(builder);
  }

  Watcher watch(WatcherBuilder builder) {
    return Watcher(builder);
  }
}

class ControlBuilder<T extends TttController> extends TttView<T> {
  final ControllerBuilder<T> controllerBuilder;

  const ControlBuilder(this.controllerBuilder, {super.key});

  @override
  Widget buildView(BuildContext context, T controller) =>
      controllerBuilder(controller);
}

extension ContextExtension on BuildContext {
  T findController<T extends TttController>() => rootState.findController<T>();

  _BindingWidgetState get rootState => BindingWidget.of(this);
}
