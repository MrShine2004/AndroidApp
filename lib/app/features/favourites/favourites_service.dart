// favourites/favourites_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cpsrpoproject/domain/repository/model/car.dart';
import 'package:cpsrpoproject/domain/repository/favourites/favourites_service_interface.dart';

class FavouritesDataService extends FavouritesServiceInterface {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  @override
  Future<List<Car>> getFavouritesData() async {
    try {
      final snapshot =
          await users.doc(FirebaseAuth.instance.currentUser!.uid).get();
      if (!snapshot.exists ||
          !snapshot.data().toString().contains('favourites')) {
        return [];
      }
      // Приведение типа данных к Map<String, dynamic>
      final data = snapshot.data() as Map<String, dynamic>;
      final carsData = data['favourites'] as List<dynamic>? ?? [];
      final cars = carsData.map((carJson) => Car.fromJson(carJson)).toList();
      return cars;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }

  @override
  Future<void> addFavouritesData(Car car) async {
    try {
      final userDocRef = users.doc(FirebaseAuth.instance.currentUser!.uid);
      final snapshot = await userDocRef.get();
      final data = snapshot.data() as Map<String, dynamic>? ?? {};
      final currentCars = data['favourites'] as List<dynamic>? ?? [];

      // Добавляем новый автомобиль в список
      final updatedCars = [...currentCars, car.toJson()];

      await userDocRef
          .set({'favourites': updatedCars}, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }

  @override
  Future<void> updateFavouritesData(List<Car> cars) async {
    try {
      final userDocRef = users.doc(FirebaseAuth.instance.currentUser!.uid);
      final updatedCars = cars.map((car) => car.toJson()).toList();
      await userDocRef
          .set({'favourites': updatedCars}, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }

  @override
  Future<void> deleteFavouritesData() async {
    try {
      final userDocRef = users.doc(FirebaseAuth.instance.currentUser!.uid);
      await userDocRef.update({'favourites': FieldValue.delete()});
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }

  @override
  Future<void> removeCarFromFavourites(String carId) async {
    try {
      final userDocRef = users.doc(FirebaseAuth.instance.currentUser!.uid);
      final snapshot = await userDocRef.get();
      final data = snapshot.data() as Map<String, dynamic>? ?? {};
      final currentCars = data['favourites'] as List<dynamic>? ?? [];

      // Удаляем автомобиль из списка по его ID
      final updatedCars = currentCars.where((carJson) {
        final car = Car.fromJson(carJson as Map<String, dynamic>);
        return car.id.toString() != carId;
      }).toList();

      if (updatedCars.isEmpty) {
        await userDocRef.update({'favourites': FieldValue.delete()});
      } else {
        await userDocRef
            .set({'favourites': updatedCars}, SetOptions(merge: true));
      }
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }
}
