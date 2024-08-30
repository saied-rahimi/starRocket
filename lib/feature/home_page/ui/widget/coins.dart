import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starship/feature/home_page/bloc/coins_cubit.dart';

class Coins extends StatefulWidget {
  const Coins(this.size, {super.key});
  final Size size;
  @override
  State<Coins> createState() => _CoinsState();
}

class _CoinsState extends State<Coins> {
  final List<Widget> _coins = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _startCoinRain();
  }

  void _startCoinRain() {
    Timer.periodic(
      Duration(milliseconds: _random.nextInt(1000) + 500),
      (timer) {
        if (!mounted) return;
        setState(() {
          if (_coins.length < 25) {
            _coins.add(_createCoin());
          }
        });
      },
    );
  }

  Widget _createCoin() {
    final duration = Duration(seconds: _random.nextInt(5) + 3);
    return Coin(
      duration: duration,
      size: widget.size,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _coins,
    );
  }
}

class Coin extends StatelessWidget {
  final Duration duration;
  final Size size;

  const Coin({
    super.key,
    required this.duration,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CoinCubit()..initialize(size),
      child: BlocBuilder<CoinCubit, CoinState>(
        builder: (context, state) {
          return AnimatedPositioned(
            duration: duration,
            top: state.topPosition,
            left: state.leftPosition,
            child: Image.asset(
              'asset/star.png',
              width: 30,
              height: 30,
            ),
          );
        },
      ),
    );
  }
}
