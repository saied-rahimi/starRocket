import 'package:flutter/material.dart';

class ArrowWidget extends StatefulWidget {
  const ArrowWidget({
    super.key,
    required this.size,
    required this.onTap,
    required this.onLongPressStart,
    required this.onLongPressEnd,
    this.flip = false,
  });

  final Size size;
  final bool flip;
  final VoidCallback onTap;
  final VoidCallback onLongPressStart;
  final VoidCallback onLongPressEnd;

  @override
  State<ArrowWidget> createState() => _ArrowWidgetState();
}

class _ArrowWidgetState extends State<ArrowWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 0.8).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
    widget.onLongPressStart();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onLongPressEnd();
  }

  void _onTapCancel() {
    _controller.reverse();
    widget.onLongPressEnd();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: 130,
      width: 50,
      top: widget.size.height - 150,
      left: widget.flip ? 20 : widget.size.width - 70,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: ScaleTransition(
          scale: _animation,
          child: Transform.flip(
            flipX: widget.flip,
            child: Image.asset('asset/arrow_right.png'),
          ),
        ),
      ),
    );
  }
}
