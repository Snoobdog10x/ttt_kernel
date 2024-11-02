part of "ttt_controller.dart";

class TttControllerProvider extends StatefulWidget {
  final TttController Function() controllerBuilder;
  final Widget view;

  const TttControllerProvider({
    super.key,
    required this.controllerBuilder,
    required this.view,
  });

  @override
  TttController createState() => controllerBuilder();
}
