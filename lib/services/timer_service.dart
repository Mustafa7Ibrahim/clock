import 'dart:async';

import 'package:flutter/material.dart';

class TimerService extends ChangeNotifier {
  Stopwatch _stopWatch;
  Timer _timer;

  // Duration get currentDuration => _currentDuration;
  Duration currentDuration = Duration.zero;

  bool get isRunning => _timer != null;

  TimerService() {
    _stopWatch = Stopwatch();
  }

  String printDuration() {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(currentDuration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(currentDuration.inSeconds.remainder(60));
    return "${twoDigits(currentDuration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void _onTick(Timer timer) {
    currentDuration = _stopWatch.elapsed;
    notifyListeners();
  }

  void start() {
    if (_timer != null) return;

    _timer = Timer.periodic(Duration(seconds: 1), _onTick);
    _stopWatch.start();

    notifyListeners();
  }

  void pouse() {
    _timer?.cancel();
    _timer = null;
    _stopWatch.stop();
    currentDuration = _stopWatch.elapsed;

    notifyListeners();
  }

  void stop() {
    pouse();
    _stopWatch.reset();
    currentDuration = Duration.zero;

    notifyListeners();
  }
}
