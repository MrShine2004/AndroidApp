part of 'favourites_bloc.dart';

sealed class FavouritesState extends Equatable {
  const FavouritesState();

  @override
  List<Object> get props => [];
}

final class FavouritesInitial extends FavouritesState {}

final class FavouritesLoadInProgress extends FavouritesState {}

final class FavouritesLoadSuccess extends FavouritesState {
  const FavouritesLoadSuccess({
    required this.favourites,
  });

  final List<Car> favourites;

  @override
  List<Object> get props => [favourites];
}

final class FavouritesLoadFailure extends FavouritesState {
  const FavouritesLoadFailure({
    required this.exception,
  });

  final Object? exception;

  @override
  List<Object> get props => [exception!];
}
