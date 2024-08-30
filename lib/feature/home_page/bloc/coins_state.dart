part of 'coins_cubit.dart';

class CoinState {
  final double topPosition;
  final double leftPosition;
  final bool isActive;

  const CoinState({
    required this.topPosition,
    required this.leftPosition,
    this.isActive = true,
  });

  List<Object> get props => [topPosition, leftPosition, isActive];
}
