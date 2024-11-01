library ttt_extension;

import 'dart:async';

class Bouncer {
  Duration duration;
  Timer? timer;

  Bouncer({this.duration = const Duration(milliseconds: 200)});

  void run(void Function() callback) {
    cancel();
    timer = Timer(duration, callback);
  }

  void cancel() {
    timer?.cancel();
    timer = null;
  }
}

extension DurationExtension on num {
  int get _roundDuration => (this * 1000).round();

  Duration get millis => Duration(microseconds: _roundDuration);

  Duration get seconds => Duration(milliseconds: _roundDuration);

  Duration get minutes => Duration(milliseconds: (this * 60)._roundDuration);

  Duration get hours => Duration(milliseconds: (this * 60 * 60)._roundDuration);
}

extension DelayExtension on Duration {
  Future<void> delay([void Function()? callback]) {
    return Future.delayed(this, callback);
  }
}

extension BouncerExtension on num {
  Bouncer get bounce => Bouncer(duration: millis);
}
