import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppStateInitial()) {
    _startTimer();
  }

  Timer? _timer;
  int _remainingTime = 180; // 3 minutes in seconds
  int _score = 0; // Initialize score

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        _remainingTime--;
        emit(StateUpdated(_remainingTime, _score));
      } else {
        _timer?.cancel();
      }
    });
  }

  void updateScore(int score) {
    _score = score; // Update score
    emit(StateUpdated(_remainingTime, _score));
  }
}
