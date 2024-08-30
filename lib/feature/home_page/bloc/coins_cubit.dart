import 'dart:math';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

part 'coins_state.dart';

class CoinCubit extends Cubit<CoinState> {
  final Random _random = Random();
  final Function() onCollision;
  final int _fallDuration = 3000; // Fall duration in milliseconds
  late final Timer _timer;

  CoinCubit({required this.onCollision})
      : super(const CoinState(topPosition: 0, leftPosition: 0));

  void initialize(Size size) {
    emit(CoinState(
      topPosition: 0,
      leftPosition: _random.nextDouble() * size.width,
    ));

    _startFalling(size);
  }

  void _startFalling(Size size) {
    final startTime = DateTime.now();

    _timer = Timer.periodic(Duration(milliseconds: 16), (timer) {
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

      checkCollision(size.width / 2 - 25, 50, size);
    });
  }

  void checkCollision(double rocketX, int rocketWidth, Size size) {
    if (state.topPosition >= size.height - 50 && // Near the bottom of the screen where the rocket is
        state.leftPosition >= rocketX &&
        state.leftPosition <= rocketX + rocketWidth) {
      onCollision(); // Trigger the collision callback
      _timer.cancel();
      emit(CoinState(
        topPosition: state.topPosition,
        leftPosition: state.leftPosition,
        isVisible: false, // Hide the coin after collision
      ));
    }
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
