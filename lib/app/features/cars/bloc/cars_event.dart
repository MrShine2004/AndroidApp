part of 'cars_bloc.dart';

sealed class CarsEvent extends Equatable {
  const CarsEvent();

  @override
  List<Object> get props => [];
}

class CarsLoad extends CarsEvent {
  final Car car;
  const CarsLoad({required this.car});

  @override
  List<Object> get props => [car];
}
