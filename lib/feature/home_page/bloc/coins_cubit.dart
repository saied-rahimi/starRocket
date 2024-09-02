import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'coins_state.dart';

class CoinsCubit extends Cubit<CoinsState> {
  final Random _random = Random();
  final Function(int) onCollision;
  final Size size;
  final double rocketWidth;
  Timer? _coinTimer;
  List<int> collectedCoinId = [];

  CoinsCubit({required this.onCollision, required this.size, required this.rocketWidth}) : super(CoinsState(coins: []));

  void startCoinRain() {
    _coinTimer = Timer.periodic(
      Duration(milliseconds: _random.nextInt(3000) + 1000),
      (timer) {
        if (state.coins.length < 25 && collectedCoinId.length < 5) {
          addCoin();
        }
      },
    );
  }

  void addCoin() {
    final coin = CoinState(
      id: state.coins.length,
      topPosition: 10,
      leftPosition: _random.nextDouble() * size.width,
      isActive: true,
    );
    emit(CoinsState(coins: List.from(state.coins)..add(coin)));
    startCoinFalling(coin);
  }

  void startCoinFalling(CoinState coin) {
    final fallDuration = Duration(seconds: _random.nextInt(5) + 3);
    final startTime = DateTime.now();

    Timer.periodic(const Duration(milliseconds: 16), (timer) {
      final elapsed = DateTime.now().difference(startTime).inMilliseconds;

      if (elapsed >= fallDuration.inMilliseconds) {
        timer.cancel();
        deactivateCoin(coin);
        return;
      }

      final newTopPosition = (elapsed / fallDuration.inMilliseconds) * size.height;

      updateCoinPosition(coin, newTopPosition);
    });
  }

  void updateCoinPosition(CoinState coin, double newTopPosition) {
    final updatedCoin = coin.copyWith(topPosition: newTopPosition);

    final updatedCoins = state.coins.map((c) {
      return c.id == coin.id ? updatedCoin : c;
    }).toList();

    emit(CoinsState(coins: updatedCoins));
  }

  void checkCollision(double rocketX) {
    for (final coin in state.coins) {
      if (coin.isActive &&
          coin.topPosition >= size.height - 150 &&
          coin.leftPosition >= rocketX &&
          coin.leftPosition <= rocketX + rocketWidth &&
          !collectedCoinId.contains(coin.id)) {
        collectedCoinId.add(coin.id);
        onCollision(10);
        deactivateCoin(coin);
        return;
      }
    }
  }

  void deactivateCoin(CoinState coin) {
    final updatedCoin = coin.copyWith(isActive: false);
    final updatedCoins = state.coins.map((c) {
      return c.id == coin.id ? updatedCoin : c;
    }).toList();

    emit(CoinsState(coins: updatedCoins));
  }

  @override
  Future<void> close() {
    _coinTimer?.cancel();
    return super.close();
  }
}
