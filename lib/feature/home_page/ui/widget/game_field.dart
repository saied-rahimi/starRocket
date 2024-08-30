import 'package:flutter/material.dart';
import 'package:starship/feature/home_page/ui/widget/arrow_widget.dart';
import 'package:starship/feature/home_page/ui/widget/rocket_widget.dart';

class GameField extends StatefulWidget {
  const GameField(this.size, {super.key});
  final Size size;

  @override
  State<GameField> createState() => _GameFieldState();
}

class _GameFieldState extends State<GameField> {
  double rocketPositionX = 0;

  @override
  void initState() {
    super.initState();
    rocketPositionX = (widget.size.width - 50) / 2;
  }

  void moveRocket(bool moveLeft) {
    setState(() {
      if (moveLeft) {
        rocketPositionX += 20;
      } else {
        rocketPositionX -= 20;
      }

      // Ensure the rocket stays within the screen bounds
      final screenWidth = MediaQuery.of(context).size.width;
      if (rocketPositionX < 0) {
        rocketPositionX = 0;
      } else if (rocketPositionX > screenWidth - 50) {
        rocketPositionX = screenWidth - 50;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RocketWidget(
          size: widget.size,
          positionX: rocketPositionX,
        ),
        ArrowWidget(
          size: widget.size,
          onTap: () => moveRocket(true), // Move left
        ),
        ArrowWidget(
          size: widget.size,
          onTap: () => moveRocket(false), // Move right
          flip: true,
        ),
      ],
    );
  }
}
