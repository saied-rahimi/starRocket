part of 'coins_cubit.dart';

class CoinState extends Equatable {
  final double topPosition;
  final double leftPosition;

  const CoinState({
    required this.topPosition,
    required this.leftPosition,
  });

  @override
  List<Object> get props => [topPosition, leftPosition];
}