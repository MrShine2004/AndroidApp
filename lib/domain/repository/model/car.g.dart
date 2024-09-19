// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Car _$CarFromJson(Map<String, dynamic> json) => Car(
      id: (json['id'] as num).toInt(),
      brand: json['brand'] as String,
      model: json['model'] as String,
      year: (json['year'] as num).toInt(),
      country: (json['country'] as num).toInt(),
      parts: (json['parts'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      imgPath: json['image'] as String,
    );

Map<String, dynamic> _$CarToJson(Car instance) => <String, dynamic>{
      'id': instance.id,
      'brand': instance.brand,
      'model': instance.model,
      'year': instance.year,
      'country': instance.country,
      'parts': instance.parts,
      'image': instance.imgPath,
    };
