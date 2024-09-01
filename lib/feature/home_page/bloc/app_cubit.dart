import 'dart:async';
import 'package:bloc/bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppStateInitial()) {
    _startTimer();
  }

  Timer? _timer;
  int _remainingTime = 180;
  int appScore = 0;
  void cancelTimer() {
    _timer?.cancel();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0 && appScore < 50) {
        _remainingTime--;
        emit(StateUpdated(_remainingTime, appScore));
      } else {
        _timer?.cancel();
      }
    });
  }

  void updateScore(int score) {
    appScore += score;
    emit(StateUpdated(_remainingTime, appScore));
  }
}
