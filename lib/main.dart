import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cpsrpoproject/di/di.dart';
import 'package:cpsrpoproject/cpsrpoproject.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupLocator();

  FlutterError.onError = (details) => talker.handle(
        details.exception,
        details.stack,
      );

  runApp(const CarsListApp());
}
