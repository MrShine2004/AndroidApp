import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cpsrpoproject/domain/repository/cars/cars_repository.dart';
import 'package:cpsrpoproject/domain/repository/model/car.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:cpsrpoproject/di/di.dart';
import 'package:cpsrpoproject/cpsrpoproject.dart';

part 'cars_event.dart';
part 'cars_state.dart';

class CarsBloc extends Bloc<CarsEvent, CarsState> {
  final CarsRepository carsRepository;

  CarsBloc(this.carsRepository) : super(CarsInitial()) {
    on<CarsLoad>(_onCarsLoad);
  }

  Future<void> _onCarsLoad(CarsLoad event, Emitter<CarsState> emit) async {
    try {
      emit(CarsLoadInProgress());

      // Делаем запрос к API для получения машины по ID
      final car = await carsRepository.getCarById(event.carId);

      emit(CarsLoadSuccess(car: car)); // Отправляем машину в состояние успеха
    } catch (error, stackTrace) {
      print('Ошибка загрузки машины: $error');
      emit(CarsLoadFailure(exception: error));
      talker.handle(error, stackTrace); // Логируем ошибку через Talker
    }
  }
}
