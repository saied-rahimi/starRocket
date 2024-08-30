import 'package:bloc/bloc.dart';

part 'rocket_state.dart';

class RocketCubit extends Cubit<RocketState> {
  final double screenWidth;

  RocketCubit(this.screenWidth) : super(RocketState(positionX: (screenWidth - 50) / 2));

  void moveRocket(bool moveLeft) {
    double newPositionX = moveLeft ? state.positionX + 20 : state.positionX - 20;
    if (newPositionX < 0) {
      newPositionX = 0;
    } else if (newPositionX > screenWidth - 50) {
      newPositionX = screenWidth - 50;
    }

    emit(RocketState(positionX: newPositionX));
  }
}
