import 'package:cpsrpoproject/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cpsrpoproject/app/app.dart';

class CarCard extends StatelessWidget {
  final Car car; // Добавляем поле для машины

  const CarCard({
    super.key,
    required this.car,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/home/cars/${car.id}', extra: car.id);
      },
      borderRadius: BorderRadius.circular(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: car.imgPath != null
                ? Image.network(
                    car.imgPath!, // Безопасно используем imgPath, так как проверили на null
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Если изображение не загрузится, будет показана заглушка
                      return Image.asset(
                        'assets/images/car.jpg', // Путь к заглушке
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      );
                    },
                  )
                : Image.asset(
                    'assets/images/car.jpg', // Заглушка, если imgPath == null
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
          ),
          20.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${car.brand} ${car.model}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                5.ph,
                Text(
                  'Год выпуска ${car.year}',
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
