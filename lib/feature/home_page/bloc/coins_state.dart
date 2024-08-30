part of 'coins_cubit.dart';

class CoinState extends Equatable {
  final double topPosition;
  final double leftPosition;
  final bool isVisible;

  const CoinState({
    required this.topPosition,
    required this.leftPosition,
    this.isVisible = true,
  });

  @override
  List<Object> get props => [topPosition, leftPosition, isVisible];
}
