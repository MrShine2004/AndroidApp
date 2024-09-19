import 'package:flutter/material.dart';
import 'package:cpsrpoproject/app/app.dart';
import 'package:cpsrpoproject/domain/repository/model/model.dart';

class CarsDiscriptionScreen extends StatefulWidget {
  final Car car; // Добавляем поле для машины

  const CarsDiscriptionScreen({
    super.key,
    required this.car,
  });
  @override
  State<CarsDiscriptionScreen> createState() => _CarsDiscriptionScreenState();
}

class _CarsDiscriptionScreenState extends State<CarsDiscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    final car = widget.car; // Получаем переданный объект

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Описание',
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${car.brand} ${car.model}', // Используем данные из car
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              20.ph,
              Image.asset(
                'assets/images/car.jpg',
                fit: BoxFit.cover,
              ),
              10.ph,
              Text(
                'Год выпуска ${car.year}', // Замени на нужное описание
                style: Theme.of(context).textTheme.labelSmall,
              ),
              10.ph,
              Text(
                'Запчасти: ${car.parts.join(', ')}', // Замени на нужное описание
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Text(
                'Страна ${car.country}', // Замени на нужное описание
                style: Theme.of(context).textTheme.labelSmall,
              )
            ],
          ),
        ),
      ),
    );
  }
}
