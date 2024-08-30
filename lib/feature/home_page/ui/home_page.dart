import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starship/feature/home_page/bloc/app_cubit.dart';
import 'package:starship/feature/home_page/ui/widget/game_field.dart';
import 'package:starship/feature/home_page/ui/widget/option_widget.dart';
import 'package:starship/feature/home_page/ui/widget/score_bar.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => AppCubit(),
          child: BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              final size = MediaQuery.of(context).size;
              final remainingTime = state is StateUpdated ? state.remainingTime : 180;
              final score = state is StateUpdated ? state.score.toString() : '0';

              return Container(
                width: size.width,
                height: size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('asset/bg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    GameField(size),
                    ScoreBar(time: _formatTime(remainingTime), score: score),
                    OptionWidget(size),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  String _formatTime(int remainingTime) {
    final minutes = (remainingTime ~/ 60).toString().padLeft(2, '0');
    final seconds = (remainingTime % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
