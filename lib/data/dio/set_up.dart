import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:cpsrpoproject/di/di.dart';

void setUpDio() {
  dio.options.baseUrl =
      'https://aleshayamolkin.pythonanywhere.com/data/api/'; // общая часть адресов запросов
  dio.options.headers['Authorization'] =
      'Token 9b90c7d29fa76cca9d5ce4e13a2413e3b65b3dc8'; // токен авторизации
  dio.options.connectTimeout = const Duration(minutes: 1);
  dio.options.receiveTimeout = const Duration(minutes: 1);
  dio.interceptors.addAll([
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printRequestData: true,
        printRequestHeaders: true,
      ),
    ),
  ]);
}
