class Endpoints {
  Endpoints._(); // Приватный конструктор для предотвращения создания экземпляра

  // Базовый URL вашего API
  static const String baseUrl =
      'https://aleshayamolkin.pythonanywhere.com/data/api';

  // Конечная точка для работы с машинами
  static const String topCars = '$baseUrl/cars/';
}
