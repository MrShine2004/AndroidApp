import 'dart:async';
import 'package:cpsrpoproject/domain/domain.dart';

abstract class CarsRepositoryIterface {
  Future<List<Car>> getCars();
}
