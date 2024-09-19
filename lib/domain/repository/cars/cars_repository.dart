import 'dart:async';
import 'package:dio/dio.dart';
import 'package:cpsrpoproject/data/data.dart';
import 'package:cpsrpoproject/domain/domain.dart';

class CarsRepository extends CarsRepositoryIterface {
  CarsRepository({required this.dio});
  final Dio dio;

  @override
  Future<List<Car>> getCars() async {
    try {
      // Добавляем токен вручную в заголовок
      final Response response = await dio.get(
        Endpoints.topCars,
        options: Options(
          headers: {
            'Authorization': 'Token 9b90c7d29fa76cca9d5ce4e13a2413e3b65b3dc8',
          },
        ),
      );

      final cars = (response.data as List).map((e) => Car.fromJson(e)).toList();
      return cars;
    } on DioException catch (e) {
      throw e.message.toString();
    }
  }
}
