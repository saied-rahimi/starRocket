import 'package:flutter/material.dart';

class RocketWidget extends StatelessWidget {
  const RocketWidget({
    super.key,
    required this.size,
    required this.positionX,
  });

  final Size size;
  final double positionX;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: 130,
      width: 50,
      top: size.height - 200,
      left: positionX,
      child: Image.asset('asset/rocket.png'),
    );
  }
}
