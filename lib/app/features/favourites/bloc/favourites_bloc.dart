// bloc/favourites_bloc.dart
import 'dart:async';
import 'package:cpsrpoproject/app/features/favourites/favourites_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cpsrpoproject/di/di.dart';
import 'package:cpsrpoproject/domain/repository/model/car.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final FavouritesDataService favouritesDataService;

  FavouritesBloc(this.favouritesDataService) : super(FavouritesInitial()) {
    on<LoadFavourites>(_loadFavourites);
    on<AddToFavourites>(_addToFavourites);
    on<RemoveFromFavourites>(_removeFromFavourites);
  }

  Future<void> _loadFavourites(
      LoadFavourites event, Emitter<FavouritesState> emit) async {
    try {
      if (state is! FavouritesLoadSuccess) {
        emit(FavouritesLoadInProgress());
      }
      final cars = await favouritesDataService.getFavouritesData();
      emit(FavouritesLoadSuccess(favourites: cars));
    } catch (exception, stackTrace) {
      emit(FavouritesLoadFailure(exception: exception));
      talker.handle(exception, stackTrace);
    } finally {
      event.completer?.complete();
    }
  }

  Future<void> _addToFavourites(
      AddToFavourites event, Emitter<FavouritesState> emit) async {
    try {
      if (state is FavouritesLoadSuccess) {
        final currentCars = (state as FavouritesLoadSuccess).favourites;
        final updatedCars = [...currentCars, event.car];
        await favouritesDataService.addFavouritesData(event.car);
        emit(FavouritesLoadSuccess(favourites: updatedCars));
      } else {
        await favouritesDataService.addFavouritesData(event.car);
        emit(FavouritesLoadSuccess(favourites: [event.car]));
      }
    } catch (exception, stackTrace) {
      emit(FavouritesLoadFailure(exception: exception));
      talker.handle(exception, stackTrace);
    }
  }

  Future<void> _removeFromFavourites(
      RemoveFromFavourites event, Emitter<FavouritesState> emit) async {
    try {
      if (state is FavouritesLoadSuccess) {
        final currentCars = (state as FavouritesLoadSuccess).favourites;
        final updatedCars = currentCars
            .where((car) => car.id.toString() != event.carId)
            .toList();
        if (updatedCars.isEmpty) {
          await favouritesDataService.deleteFavouritesData();
        } else {
          await favouritesDataService.updateFavouritesData(updatedCars);
        }
        emit(FavouritesLoadSuccess(favourites: updatedCars));
      } else {
        // Если состояние не FavouritesLoadSuccess, загрузим данные и удалим машину
        final cars = await favouritesDataService.getFavouritesData();
        final updatedCars =
            cars.where((car) => car.id.toString() != event.carId).toList();
        if (updatedCars.isEmpty) {
          await favouritesDataService.deleteFavouritesData();
        } else {
          await favouritesDataService.updateFavouritesData(updatedCars);
        }
        emit(FavouritesLoadSuccess(favourites: updatedCars));
      }
    } catch (exception, stackTrace) {
      emit(FavouritesLoadFailure(exception: exception));
      talker.handle(exception, stackTrace);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    talker.handle(error, stackTrace);
  }
}
