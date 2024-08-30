part of 'coins_cubit.dart';

class CoinsState {
  final List<CoinState> coins;

  CoinsState({required this.coins});

  List<Object> get props => [coins];
}

class CoinState {
  final int id;
  final double topPosition;
  final double leftPosition;
  final bool isActive;

  CoinState({
    required this.id,
    required this.topPosition,
    required this.leftPosition,
    required this.isActive,
  });

  CoinState copyWith({
    int? id,
    double? topPosition,
    double? leftPosition,
    bool? isActive,
  }) {
    return CoinState(
      id: id ?? this.id,
      topPosition: topPosition ?? this.topPosition,
      leftPosition: leftPosition ?? this.leftPosition,
      isActive: isActive ?? this.isActive,
    );
  }

  List<Object> get props => [topPosition, leftPosition, isActive];
}
