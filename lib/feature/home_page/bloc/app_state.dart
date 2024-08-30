part of 'app_cubit.dart';

@immutable
sealed class AppState extends Equatable {}

final class AppStateInitial extends AppState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class StateUpdated extends AppState {
  StateUpdated(this.remainingTime, this.score);

  final int remainingTime;
  final int score;
  @override
  List<Object> get props => [remainingTime, score];
}
