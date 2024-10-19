import 'package:flutter/widgets.dart';

import 'ttt_stream.dart';

class Watcher extends StatefulWidget {
  static BlocWatcherState? currentWatcherState;
  final Widget Function() builder;

  const Watcher(
    this.builder, {
    super.key,
  });

  @override
  State<Watcher> createState() => BlocWatcherState();
}

class BlocWatcherState extends State<Watcher> {
  final Set<TttStream> _subscribedStreams = {};

  @override
  void initState() {
    super.initState();
  }

  void _onValueChanged() {
    if (!mounted) {
      return;
    }

    setState(() {});
  }

  void subscribeStream(TttStream stream) {
    if (_subscribedStreams.contains(stream)) {
      return;
    }

    _subscribedStreams.add(stream);
    stream.addListener(_onValueChanged);
  }

  void _disposeStreams() {
    for (var stream in _subscribedStreams) {
      stream.removeListener(_onValueChanged);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _disposeStreams();
  }

  @override
  Widget build(BuildContext context) {
    var previousState = Watcher.currentWatcherState;
    Watcher.currentWatcherState = this;
    var child = widget.builder();
    if (_subscribedStreams.isEmpty) {
      throw Exception("child of Watcher must call Ttt stream");
    }

    Watcher.currentWatcherState = previousState;
    return child;
  }
}
