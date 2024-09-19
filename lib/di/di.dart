import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:cpsrpoproject/data/data.dart';
import 'package:cpsrpoproject/app/features/home/bloc/bloc.dart';
import 'package:cpsrpoproject/domain/repository/cars/cars_repository.dart';

final getIt = GetIt.instance;
final talker = TalkerFlutter.init();
final Dio dio = Dio();
Future<void> setupLocator() async {
  setUpDio();
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton(talker);
  getIt.registerSingleton(CarsRepository(dio: getIt<Dio>()));
  getIt.registerSingleton(HomeBloc(getIt.get<CarsRepository>()));
}
