import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerViewModel extends StateNotifier<int> {
  Timer? _timer;

  TimerViewModel() : super(120);

  void startTimer(int rateOfIncrease) {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: rateOfIncrease), (timer) {
      if (state > 0) {
        if (mounted) {
          state -= rateOfIncrease;
        }
      } else {
        _timer?.cancel();
      }
    });
  }

  void resetTimer(int rateOfIncrease) {
    _timer?.cancel();
    state = 120;
    startTimer(rateOfIncrease);
  }

  void stopTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final timerViewModelProvider =
StateNotifierProvider<TimerViewModel, int>((ref) {
  return TimerViewModel();
});
