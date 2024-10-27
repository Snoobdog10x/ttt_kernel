part of "ttt_controller.dart";

class TttMultipleControllerProvider extends StatefulWidget {
  final List<TttController Function()> controllerBuilders;
  final Widget view;

  const TttMultipleControllerProvider({
    super.key,
    required this.controllerBuilders,
    required this.view,
  });

  @override
  _TttMultipleBlocProvider createState() => _TttMultipleBlocProvider();
}

class _TttMultipleBlocProvider extends State<TttMultipleControllerProvider> {
  @override
  Widget build(BuildContext context) {
    var child = widget.view;
    for (var blocBuilder in widget.controllerBuilders.reversed) {
      child = TttControllerProvider(
        controllerBuilder: blocBuilder,
        view: child,
      );
    }

    return child;
  }
}
