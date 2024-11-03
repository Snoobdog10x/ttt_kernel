part of "ttt_controller.dart";

abstract class Binding {
  List<TttController Function()> getControllers();
}

class BindingWidget extends StatefulWidget {
  final Binding binding;
  final Widget Function() viewBuilder;

  const BindingWidget({
    super.key,
    required this.binding,
    required this.viewBuilder,
  });

  @override
  State<BindingWidget> createState() => _BindingWidgetState();

  static _BindingWidgetState of(BuildContext context) {
    var state = context.findAncestorStateOfType<_BindingWidgetState>();
    if (state == null) {
      throw Exception(
        """Not found _BindingWidgetState!!
        Please make sure you wrap parent of this context with BindingWidget""",
      );
    }

    return state;
  }
}

class _BindingWidgetState extends State<BindingWidget> with LoggerMixin {
  Widget? _child;
  final Map<String, dynamic> _controllerMap = {};

  String buildKey(Type type) {
    return type.toString();
  }

  void putController(TttController controller) {
    var key = buildKey(controller.runtimeType);
    if (_controllerMap.containsKey(key)) {
      return;
    }

    _controllerMap[key] = controller;
  }

  void deleteController(TttController controller) {
    var key = buildKey(controller.runtimeType);
    if (!_controllerMap.containsKey(key)) {
      return;
    }

    _controllerMap.remove(key);
  }

  T findController<T extends TttController>() {
    var key = buildKey(T);
    var controller = _controllerMap[key];
    if (controller is! T) {
      logError("$key not found!!!");
    }

    return controller;
  }

  @protected
  @override
  Widget build(BuildContext context) {
    _child ??= TttMultipleControllerProvider(
      controllerBuilders: widget.binding.getControllers(),
      view: widget.viewBuilder(),
    );

    return _child!;
  }

  @protected
  @override
  void dispose() {
    _controllerMap.clear();
    super.dispose();
  }
}
