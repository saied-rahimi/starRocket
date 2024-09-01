import 'dart:async';
import 'package:bloc/bloc.dart';

part 'rocket_state.dart';

class RocketCubit extends Cubit<RocketState> {
  final double screenWidth;
  Timer? _moveTimer;

  RocketCubit(this.screenWidth) : super(RocketState(positionX: (screenWidth - 50) / 2));

  void moveRocket(bool moveLeft) {
    _moveTimer?.cancel();
    _moveTimer = Timer.periodic(const Duration(milliseconds: 16), (_) {
      double newPositionX = moveLeft ? state.positionX + 5 : state.positionX - 5;
      if (newPositionX < 0) {
        newPositionX = 0;
      } else if (newPositionX > screenWidth - 50) {
        newPositionX = screenWidth - 50;
      }

      emit(RocketState(positionX: newPositionX));
    });
  }

  void stopRocket() {
    _moveTimer?.cancel();
  }

  @override
  Future<void> close() {
    _moveTimer?.cancel();
    return super.close();
  }
}
