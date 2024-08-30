part of 'app_cubit.dart';

sealed class AppState {}

final class AppStateInitial extends AppState {}

class StateUpdated extends AppState {
  StateUpdated(this.remainingTime, this.score);

  final int remainingTime;
  final int score;

  List<Object> get props => [remainingTime, score];
}
