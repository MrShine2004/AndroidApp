part of 'cars_bloc.dart';

sealed class CarsEvent extends Equatable {
  const CarsEvent();

  @override
  List<Object> get props => [];
}

class CarsLoad extends CarsEvent {
  final int carId; // Используем int для идентификатора машины

  const CarsLoad({required this.carId}); // Передаем carId как int

  @override
  List<Object> get props => [carId]; // Добавляем carId в props
}
