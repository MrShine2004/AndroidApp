part of 'cars_bloc.dart';

sealed class CarsState extends Equatable {
  const CarsState();

  @override
  List<Object> get props => [];
}

final class CarsInitial extends CarsState {}

final class CarsLoadInProgress extends CarsState {}

final class CarsLoadSuccess extends CarsState {
  const CarsLoadSuccess({
    required this.car,
  });
  final Car car;
  @override
  List<Object> get props => [car];
}

final class CarsLoadFailure extends CarsState {
  const CarsLoadFailure({
    this.exception,
  });

  final Object? exception;
  @override
  List<Object> get props => [];
}
