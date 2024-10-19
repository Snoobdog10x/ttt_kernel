import 'package:flutter/widgets.dart';

import 'ttt_controller.dart';

class TttControllerProvider extends StatefulWidget {
  final TttController Function() blocBuilder;
  final Widget Function() viewBuilder;
  final String? tag;

  const TttControllerProvider({
    super.key,
    required this.blocBuilder,
    required this.viewBuilder,
    this.tag,
  });

  @override
  TttController createState() => blocBuilder();
}
