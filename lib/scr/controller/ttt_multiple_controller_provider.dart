part of "ttt_controller.dart";

class TttMultipleControllerProvider extends StatefulWidget {
  final List<TttController Function()> blocBuilders;
  final Widget Function() viewBuilder;

  const TttMultipleControllerProvider({
    super.key,
    required this.blocBuilders,
    required this.viewBuilder,
  });

  @override
  _TttMultipleBlocProvider createState() => _TttMultipleBlocProvider();
}

class _TttMultipleBlocProvider extends State<TttMultipleControllerProvider> {
  @override
  Widget build(BuildContext context) {
    Widget Function() childBuilder = widget.viewBuilder;
    for (var blocBuilder in widget.blocBuilders) {
      childBuilder = () => TttControllerProvider(
            blocBuilder: blocBuilder,
            viewBuilder: childBuilder,
          );
    }

    return childBuilder();
  }
}
