import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'car.g.dart';

@JsonSerializable()
class Car {
  Car({
    required this.id,
    required this.brand,
    required this.model,
    required this.year,
    required this.country,
    required this.parts,
    required this.imgPath,
  });

  final int id;
  final String brand;
  final String model;
  final int year;
  final int country;
  final List<int> parts;
  final String imgPath; // Хранится как строка пути к изображению

  // Метод для получения объекта Image
  Image get image => Image.network(imgPath);

  factory Car.fromJson(Map<String, dynamic> json) => _$CarFromJson(json);
  Map<String, dynamic> toJson() => _$CarToJson(this);

  @override
  String toString() {
    return 'Car(id: $id, brand: $brand, model: $model)'; // Вывод нужных данных
  }
}
