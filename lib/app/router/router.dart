import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:cpsrpoproject/app/app.dart';
import 'package:cpsrpoproject/di/di.dart';
import 'package:cpsrpoproject/domain/repository/model/model.dart';

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
      // для следующей лабораторной работы
      routes: [
        GoRoute(
          path: 'home/cars/:id',
          builder: (context, state) {
            final car = state.extra;

            if (car == null || car is! Car) {
              return Scaffold(
                body: Center(child: Text('Машина не найдена')),
              );
            }

            return CarsDiscriptionScreen(car: car as Car);
          },
        ),
      ],
    ),
  ],
);
