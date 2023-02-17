part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

/// Событие вызывается при запросе данных с api.
///
class WeatherFetching extends WeatherEvent {}

/// Событие вызывается при инициализации
class WeatherTodayOpened extends WeatherEvent {
  const WeatherTodayOpened({required this.weatherList});

  final List<Weather> weatherList;

  @override
  List<Object> get props => [weatherList];
}

/// Событие вызывается при переходе на экран с прогнозом погоды
class WeatherForecastOpened extends WeatherEvent {
  const WeatherForecastOpened({required this.weatherList});

  final List<Weather> weatherList;

  @override
  List<Object> get props => [weatherList];
}
