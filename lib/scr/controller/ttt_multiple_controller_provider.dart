part of "ttt_controller.dart";

class TttMultipleControllerProvider extends StatefulWidget {
  final List<TttController Function()> blocBuilders;
  final Widget view;

  const TttMultipleControllerProvider({
    super.key,
    required this.blocBuilders,
    required this.view,
  });

  @override
  _TttMultipleBlocProvider createState() => _TttMultipleBlocProvider();
}

class _TttMultipleBlocProvider extends State<TttMultipleControllerProvider> {
  @override
  Widget build(BuildContext context) {
    var child = widget.view;
    for (var blocBuilder in widget.blocBuilders.reversed) {
      child = TttControllerProvider(
        blocBuilder: blocBuilder,
        view: child,
      );
    }

    return child;
  }
}
