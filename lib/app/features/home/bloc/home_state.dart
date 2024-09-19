part of "home_bloc.dart";

sealed class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoadInProgress extends HomeState {}

final class HomeLoadSuccess extends HomeState {
  const HomeLoadSuccess({
    required this.cars,
  });
  final List<Car> cars;
  @override
  List<Object> get props => [cars];
}

final class HomeLoadFailure extends HomeState {
  const HomeLoadFailure({
    required this.exception,
  });
  final Object? exception;
  @override
  List<Object> get props => [];
}
