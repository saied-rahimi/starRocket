import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starship/feature/home_page/bloc/rocket_cubit.dart';
import 'package:starship/feature/home_page/ui/widget/arrow_widget.dart';
import 'package:starship/feature/home_page/ui/widget/coins.dart';
import 'package:starship/feature/home_page/ui/widget/rocket_widget.dart';

class GameField extends StatelessWidget {
  final Size size;

  const GameField(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RocketCubit(size.width),
      child: BlocBuilder<RocketCubit, RocketState>(
        builder: (context, state) {
          return Stack(
            children: [
              Coins(
                size,
                rocketPositionX: state.positionX,
                rocketWidth: 50,
              ),
              RocketWidget(
                size: size,
                positionX: state.positionX,
              ),
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
      ),
    );
  }
}
