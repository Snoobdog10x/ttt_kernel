part of "ttt_controller.dart";

class TttControllerProvider extends StatefulWidget {
  final TttController Function() controllerBuilder;
  final Widget view;
  final String? tag;

  const TttControllerProvider({
    super.key,
    required this.controllerBuilder,
    required this.view,
    this.tag,
  });

  @override
  TttController createState() => controllerBuilder();
}
