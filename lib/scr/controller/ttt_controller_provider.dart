part of "ttt_controller.dart";

class TttControllerProvider extends StatefulWidget {
  final TttController Function() blocBuilder;
  final Widget view;
  final String? tag;

  const TttControllerProvider({
    super.key,
    required this.blocBuilder,
    required this.view,
    this.tag,
  });

  @override
  TttController createState() => blocBuilder();
}
