// domain/repository/favourites/favourites_service_interface.dart
import 'package:cpsrpoproject/domain/repository/model/car.dart';

abstract class FavouritesServiceInterface {
  Future<List<Car>> getFavouritesData();
  Future<void> addFavouritesData(Car car);
  Future<void> updateFavouritesData(List<Car> cars); // Изменено на List<Car>
  Future<void> deleteFavouritesData();
  Future<void> removeCarFromFavourites(String carId); // Добавлен новый метод
}
