part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

/// Состояние при нахождении на экране с погодой на данный момент.
class WeatherToday extends WeatherState {
  const WeatherToday({required this.weatherList});

  final List<Weather> weatherList;
}

/// Состояние после получении ошибки при запросе данных.
class WeatherFetchingFailure extends WeatherState {}

/// Состояние при нахождении на экране с прогнозом погоды.
class WeatherForecast extends WeatherState {
  const WeatherForecast({required this.weatherList});

  final List<Weather> weatherList;

  /// Возвращает отсортированный по дате список
  List<Weather> get sortedWeatherList {
    List<Weather> sortedList = weatherList;
    sortedList.sort((a, b) => a.date.compareTo(b.date));
    return sortedList;
  }
}
