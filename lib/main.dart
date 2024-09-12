import 'package:flutter/material.dart';
import 'package:cpsrpoproject/di/di.dart';
import 'package:cpsrpoproject/cpsrpoproject.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  FlutterError.onError = (details) => talker.handle(
        details.exception,
        details.stack,
      );
  runApp(const CarsListApp());
}
