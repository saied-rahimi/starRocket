import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starship/feature/home_page/bloc/app_cubit.dart';
import 'package:starship/feature/home_page/bloc/coins_cubit.dart';
import 'package:starship/feature/home_page/bloc/rocket_cubit.dart';
import 'package:starship/feature/home_page/ui/widget/arrow_widget.dart';
import 'package:starship/feature/home_page/ui/widget/rocket_widget.dart';

class GameField extends StatelessWidget {
  final Size size;

  const GameField(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => RocketCubit(size.width),
        ),
        BlocProvider(
          create: (_) => CoinsCubit(
            onCollision: (score) => context.read<AppCubit>().updateScore(score),
            size: size,
            rocketWidth: 80,
          )..startCoinRain(),
        )
      ],
      child: BlocBuilder<RocketCubit, RocketState>(
        builder: (context, rocketState) {
          return BlocBuilder<CoinsCubit, CoinsState>(
            builder: (context, coinsState) {
              context.read<CoinsCubit>().checkCollision(rocketState.positionX);
              if (coinsState.coins.isNotEmpty) {
                // debugPrint('state is: 1 ${coinsState.coins[0].isActive}');
              }
              return Stack(
                children: [
                  ...coinsState.coins
                      .where((coin) => coin.isActive) // Only active coins are rendered
                      .map((coin) {
                    return Positioned(
                      top: coin.topPosition,
                      left: coin.leftPosition,
                      child: Image.asset(
                        'asset/star.png',
                        width: 30,
                        height: 30,
                      ),
                    );
                  }),
                  RocketWidget(size: size, positionX: rocketState.positionX),
                  ArrowWidget(
                    size: size,
                    onTap: () {
                      context.read<RocketCubit>().moveRocket(true);
                    },
                  ),
                  ArrowWidget(
                    size: size,
                    onTap: () {
                      context.read<RocketCubit>().moveRocket(false);
                    },
                    flip: true,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
