import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:cpsrpoproject/app/app.dart';
import 'package:cpsrpoproject/di/di.dart';
import 'package:cpsrpoproject/domain/repository/model/model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final GlobalKey<NavigatorState> _rootNavigationKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  observers: [TalkerRouteObserver(talker)],
  initialLocation: '/home',
  navigatorKey: _rootNavigationKey,
  routes: <RouteBase>[
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) {
        return NoTransitionPage<void>(
          key: state.pageKey,
          child: const HomeScreen(),
        );
      },
      routes: [
        GoRoute(
          path: 'cars/:id',
          pageBuilder: (context, state) {
            final carIdString =
                state.pathParameters['id']; // Получаем параметр из маршрута
            if (carIdString == null) {
              return NoTransitionPage<void>(
                key: state.pageKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Машина не найдена :(',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    20.ph,
                    const HomeScreen(),
                  ],
                ),
              );
            }

            final carId = int.tryParse(carIdString); // Преобразуем строку в int
            if (carId == null) {
              return NoTransitionPage<void>(
                key: state.pageKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Некорректный ID машины',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    20.ph,
                    const HomeScreen(),
                  ],
                ),
              );
            }

            return NoTransitionPage<void>(
              key: state.pageKey,
              child: BlocProvider(
                create: (context) => CarsBloc(
                    getIt<CarsRepository>()), // Передаем CarsRepository
                child: CarsDiscriptionScreen(carId: carId),
              ),
            );
          },
        )
      ],
    ),
    GoRoute(
      path: '/',
      pageBuilder: (context, state) {
        return NoTransitionPage<void>(
          key: state.pageKey,
          child: const HomeScreen(),
        );
      },
    ),
  ],
);
