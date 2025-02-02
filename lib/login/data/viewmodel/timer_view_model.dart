
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerViewModel extends StateNotifier<int>{
  Timer? _timer;
  TimerViewModel():super(120);
  void startTimer() {
     _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state > 0) {
        if (mounted) {
         state--;
        }
      } else {
        _timer?.cancel();

      }
    });
  }
  void resetTimer(){
    _timer?.cancel();
    state = 120;
    startTimer();
  }
  void stopTimer(){
    _timer?.cancel();
  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
final timerViewModelProvider=StateNotifierProvider<TimerViewModel,int>((ref){
  return TimerViewModel();
});