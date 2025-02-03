import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cpsrpoproject/app/app.dart';
import 'package:cpsrpoproject/di/di.dart';
import 'package:cpsrpoproject/domain/domain.dart';
import 'package:cpsrpoproject/app/features/auth/auth_service.dart'; // Импортируем AuthService
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeBloc = HomeBloc(getIt<CarsRepository>());
  final AuthService authService = AuthService(); // Экземпляр AuthService
  @override
  void initState() {
    _homeBloc.add(const HomeLoad());
    super.initState();
  }

  void _logOut() async {
    try {
      await authService.logOut();
      context.go('/'); // Используем GoRouter для навигации
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void _goFavourite() async {
    try {
      context.push('/favourites'); // Используем GoRouter для навигации
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Главная',
          ),
          actions: [
            TextButton(onPressed: _goFavourite, child: Text('⭐')),
            TextButton(onPressed: _logOut, child: Text('🚪')),
          ],
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          bloc: _homeBloc,
          builder: (context, state) {
            if (state is HomeLoadInProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is HomeLoadSuccess) {
              List<Car> cars = state.cars;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Машины',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    20.ph,
                    ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: cars.length,
                      itemBuilder: (context, index) {
                        return CarCard(
                          car: cars[index],
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
            if (state is HomeLoadFailure) {
              return ErrorCard(
                title: 'Ошибка',
                description: state.exception.toString(),
                onReload: () {
                  _homeBloc.add(const HomeLoad());
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
