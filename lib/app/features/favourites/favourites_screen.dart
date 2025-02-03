import 'package:cpsrpoproject/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cpsrpoproject/domain/repository/model/car.dart';
import 'package:cpsrpoproject/di/di.dart';
import 'package:go_router/go_router.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  final _favouritesBloc = getIt<FavouritesBloc>();

  @override
  void initState() {
    super.initState();
    _favouritesBloc.add(LoadFavourites());
  }

  void _removeFromFavourites(String carId) {
    _favouritesBloc.add(RemoveFromFavourites(carId));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Избранное'),
        ),
        body: BlocBuilder<FavouritesBloc, FavouritesState>(
          bloc: _favouritesBloc,
          builder: (context, state) {
            if (state is FavouritesLoadInProgress) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is FavouritesLoadSuccess) {
              List<Car> favourites = state.favourites;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Избранные машины',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    20.ph,
                    ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: favourites.length,
                      itemBuilder: (context, index) {
                        final car = favourites[index];
                        return CarCard2(
                          car: car,
                          onRemove: () =>
                              _removeFromFavourites(car.id.toString()),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return 20.ph;
                      },
                    ),
                  ],
                ),
              );
            }
            if (state is FavouritesLoadFailure) {
              return ErrorCard2(
                title: 'Ошибка',
                description: state.exception.toString(),
                onReload: () {
                  _favouritesBloc.add(LoadFavourites());
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class CarCard2 extends StatelessWidget {
  final Car car;
  final VoidCallback onRemove;

  const CarCard2({
    required this.car,
    required this.onRemove,
    Key? key,
  }) : super(key: key);

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

class ErrorCard2 extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onReload;

  const ErrorCard2({
    required this.title,
    required this.description,
    required this.onReload,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
        Text(description, style: Theme.of(context).textTheme.bodyLarge),
        ElevatedButton(onPressed: onReload, child: Text('Попробовать снова')),
      ],
    );
  }
}
