import 'package:flutter/material.dart';

import 'outline_text.dart';

class ScoreBar extends StatelessWidget {
  const ScoreBar({
    super.key,
    required this.time,
    required this.score,
  });

  final String time;
  final String score;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: 100,
      width: 200,
      top: 30,
      left: 30,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'asset/score_board.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedText(
              text: 'Time: $time',
              fontSize: 30,
              outlineColor: Colors.black,
              textColor: Colors.white,
            ),
            OutlinedText(
              text: 'Score: $score/50',
              fontSize: 30,
              outlineColor: Colors.black,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
