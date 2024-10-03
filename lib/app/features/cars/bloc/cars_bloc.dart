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
  CarsBloc() : super(CarsInitial()) {
    on<CarsLoad>(_onCarsLoad);
  }

  void _onCarsLoad(CarsLoad event, Emitter<CarsState> emit) {
    try {
      print('Загружаем машину: ${event.car}'); // Логируем машину
      emit(CarsLoadSuccess(car: event.car)); // Передаем объект car напрямую
    } catch (error, stackTrace) {
      print('Ошибка загрузки машины: $error');
      emit(CarsLoadFailure(exception: error));
    }
  }
}
