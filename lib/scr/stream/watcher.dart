part of 'ttt_stream.dart';

class Watcher extends StatefulWidget {
  static WatcherState? _currentWatcherState;
  final Widget Function() builder;

  const Watcher(this.builder, {super.key});

  @override
  State<Watcher> createState() => WatcherState();
}

class WatcherState extends State<Watcher> {
  final Map<TttStream, StreamSubscription> _subscribedStreams = {};

  @override
  void initState() {
    super.initState();
  }

  void subscribeStream(TttStream stream) {
    if (_subscribedStreams.containsKey(stream)) {
      return;
    }

    _subscribedStreams[stream] = stream.subscribe((_) => _rebuild());
  }

  void _disposeStreams() {
    for (var element in _subscribedStreams.values) {
      element.cancel();
    }

    _subscribedStreams.clear();
  }

  void _rebuild() {
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _disposeStreams();
  }

  @override
  Widget build(BuildContext context) {
    var previousState = Watcher._currentWatcherState;
    Watcher._currentWatcherState = this;
    var child = widget.builder();
    if (_subscribedStreams.isEmpty) {
      throw Exception("child of Watcher must call Ttt stream");
    }

    Watcher._currentWatcherState = previousState;
    return child;
  }
}
