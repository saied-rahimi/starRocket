import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

part 'coins_state.dart';

class CoinCubit extends Cubit<CoinState> {
  final Random _random = Random();

  CoinCubit() : super(const CoinState(topPosition: 0, leftPosition: 0));

  void initialize(Size size) {
    emit(CoinState(
      topPosition: 0,
      leftPosition: _random.nextDouble() * size.width,
    ));

    Future.delayed(const Duration(milliseconds: 50), () {
      _animateCoin(size);
    });
  }

  void _animateCoin(Size size) {
    emit(CoinState(
      topPosition: size.height,
      leftPosition: state.leftPosition,
    ));
  }
}
