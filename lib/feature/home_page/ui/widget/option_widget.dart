import 'package:flutter/material.dart';

class OptionWidget extends StatelessWidget {
  const OptionWidget(
    this.size, {
    super.key,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30,
      left: size.width - 60,
      height: 50,
      width: 50,
      child: Image.asset('asset/option.png'),
    );
  }
}
