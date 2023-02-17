import 'package:yandex_weather_app/ui/constants/consts.dart';

/// Модель для описания информации о погоде.
///
class Weather {
  final String city;
  final String country;
  final String province;
  final int temperature;
  final int humidity;
  final int windSpeed;
  final int feelsLike;
  final String iconUrl;
  final String condition;
  final DateTime date;

  Weather({
    required this.city,
    required this.country,
    required this.province,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.feelsLike,
    required this.iconUrl,
    required this.condition,
    required this.date,
  });

  /// Возвращает дату в формате '<День недели>, <Число> <Месяц>'
  String get dateString {
    String weekday = Constant.week[date.weekday - 1];
    int day = date.day;
    String month = Constant.year[date.month - 1];
    return '$weekday, $day $month';
  }
}
