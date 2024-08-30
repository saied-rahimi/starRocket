import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';


part 'coins_state.dart';

class CoinCubit extends Cubit<CoinState> {
  final Random _random = Random();
  final Function() onCollision;
  late int _fallDuration;
  late int _timerInterval;
  late final Timer _timer;

  CoinCubit({required this.onCollision}) : super(const CoinState(topPosition: 0, leftPosition: 0)) {
    _fallDuration = 10000;
    _timerInterval = 16;
  }

  void initialize(Size size, double rocketX) {
    emit(CoinState(
      topPosition: 0,
      leftPosition: _random.nextDouble() * size.width,
    ));

    _startFalling(size, rocketX);
  }

  void _startFalling(Size size, double rocketX) {
    final startTime = DateTime.now();

    _timer = Timer.periodic(Duration(milliseconds: _timerInterval), (timer) {
      final elapsed = DateTime.now().difference(startTime).inMilliseconds;

      if (elapsed >= _fallDuration) {
        _timer.cancel();
        emit(CoinState(
          topPosition: size.height,
          leftPosition: state.leftPosition,
        ));
        return;
      }

      final newTopPosition = (elapsed / _fallDuration) * size.height;

      emit(CoinState(
        topPosition: newTopPosition,
        leftPosition: state.leftPosition,
      ));

      checkCollision(rocketX, size);
    });
  }

  void checkCollision(double rocketX, Size size) {
    if (state.topPosition >= size.height - 150 && state.leftPosition >= rocketX && state.leftPosition <= rocketX + 80) {
      onCollision();
      _timer.cancel();
      emit(CoinState(
        topPosition: state.topPosition,
        leftPosition: state.leftPosition,
        isActive: false,
      ));
    }
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
