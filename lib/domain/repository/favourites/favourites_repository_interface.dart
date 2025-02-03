import 'dart:async';
import 'package:cpsrpoproject/domain/domain.dart';

abstract class FavouritesRepositoryIterface {
  Future<List<Car>> getFavouritesData();
}
