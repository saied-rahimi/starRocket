import 'package:flutter/material.dart';

class ArrowWidget extends StatelessWidget {
  const ArrowWidget({
    super.key,
    required this.size,
    required this.onTap,
    this.flip = false,
  });

  final Size size;
  final bool flip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: 130,
      width: 50,
      top: size.height - 150,
      left: flip ? 20 : size.width - 70,
      child: InkWell(
        onTap: onTap,
        child: Transform.flip(
          flipX: flip,
          child: Image.asset('asset/arrow_right.png'),
        ),
      ),
    );
  }
}
