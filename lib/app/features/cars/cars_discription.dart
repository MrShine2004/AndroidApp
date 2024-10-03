import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cpsrpoproject/app/app.dart';
import 'package:cpsrpoproject/di/di.dart';
import 'package:cpsrpoproject/domain/domain.dart';
import 'package:cpsrpoproject/app/features/cars/bloc/cars_bloc.dart'; // Импортируем CarsBloc

class CarsDiscriptionScreen extends StatefulWidget {
  final int carId;

  const CarsDiscriptionScreen({
    super.key,
    required this.carId,
  });

  @override
  State<CarsDiscriptionScreen> createState() => _CarsDiscriptionScreenState();
}

class _CarsDiscriptionScreenState extends State<CarsDiscriptionScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Отправляем событие для загрузки данных машины
    context.read<CarsBloc>().add(CarsLoad(carId: widget.carId));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Описание'),
        ),
        body: BlocBuilder<CarsBloc, CarsState>(
          builder: (context, state) {
            if (state is CarsLoadInProgress) {
              // Показываем индикатор загрузки
              return const Center(child: CircularProgressIndicator());
            } else if (state is CarsLoadSuccess) {
              final car = state.car; // Получаем данные машины из состояния

              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${car.brand} ${car.model}',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    20.ph,
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: car.imgPath != null
                          ? Image.network(
                              car.imgPath!,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/car.jpg',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                );
                              },
                            )
                          : Image.asset(
                              'assets/images/car.jpg', // Заглушка, если imgPath == null
                              fit: BoxFit.cover,
                            ),
                    ),
                    10.ph,
                    Text(
                      'Год выпуска ${car.year}',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    10.ph,
                    Text(
                      'Запчасти: ${car.parts.join(', ')}',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    Text(
                      'Страна ${car.country}',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              );
            } else if (state is CarsLoadFailure) {
              // Если произошла ошибка, показываем сообщение
              return Center(
                child: Text(
                  'Ошибка: ${state.exception}',
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
            // Если нет данных, показываем заглушку
            return const Center(child: Text('Машина не найдена'));
          },
        ),
      ),
    );
  }
}
