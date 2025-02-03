part of 'favourites_bloc.dart';

sealed class FavouritesEvent extends Equatable {
  const FavouritesEvent();

  @override
  List<Object> get props => [];
}

class LoadFavourites extends FavouritesEvent {
  const LoadFavourites({this.completer});
  final Completer? completer;

  @override
  List<Object> get props => [if (completer != null) completer!];
}

class AddToFavourites extends FavouritesEvent {
  final Car car;
  const AddToFavourites(this.car);

  @override
  List<Object> get props => [car];
}

class RemoveFromFavourites extends FavouritesEvent {
  final String carId;
  const RemoveFromFavourites(this.carId);

  @override
  List<Object> get props => [carId];
}
