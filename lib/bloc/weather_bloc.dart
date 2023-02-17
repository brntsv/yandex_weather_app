import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yandex_weather_app/models/location.dart';
import 'package:yandex_weather_app/models/weather.dart';
import 'package:yandex_weather_app/service.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherTodayOpened>(_weatherTodayOpenedHandler);
    on<WeatherForecastOpened>(_weatherForecastOpenedHandler);
    on<WeatherFetching>(_weatherFetchingHandler);
  }

  Future<void> _weatherTodayOpenedHandler(
      WeatherTodayOpened event, Emitter<WeatherState> emit) async {
    emit(WeatherToday(weatherList: event.weatherList));
  }

  Future<void> _weatherForecastOpenedHandler(
      WeatherForecastOpened event, Emitter<WeatherState> emit) async {
    emit(WeatherForecast(weatherList: event.weatherList));
  }

  Future<AppLatLon> _fetchCurrentLocation() async {
    AppLatLon location;
    const defLocation = MoscowLocation();
    try {
      location = await LocationService().getCurrentLocation();
      return location;
    } catch (_) {
      location = defLocation;
      return location;
    }
  }

  Future<void> _weatherFetchingHandler(
      WeatherFetching event, Emitter<WeatherState> emit) async {
    AppLatLon location = await _fetchCurrentLocation();
    try {
      print(location.lat);
      print(location.lon);
      List<Weather> weatherList = await WeatherService.getWeather(location);
      print(weatherList);
      emit(WeatherToday(weatherList: weatherList));
    } catch (e) {
      emit(WeatherFetchingFailure());
    }
  }
}
