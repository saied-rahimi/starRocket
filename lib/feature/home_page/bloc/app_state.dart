part of 'app_cubit.dart';


sealed class AppState {}

final class AppStateInitial extends AppState {
  List<Object?> get props => throw UnimplementedError();
}

class StateUpdated extends AppState {
  StateUpdated(this.remainingTime, this.score);

  final int remainingTime;
  final int score;

  List<Object> get props => [remainingTime, score];
}
