import 'package:dio/dio.dart';
import 'package:yandex_weather_app/models/location.dart';
import 'package:yandex_weather_app/models/weather.dart';

class WeatherService {
  static const String _apiKey = 'YOUR API KEY';

  static Future<List<Weather>> getWeather(AppLatLon location) async {
    double lat = location.lat;
    double lon = location.lon;

    var weatherUrl =
        'https://api.weather.yandex.ru/v2/forecast?lat=$lat&lon=$lon&limit=7&hours=false';

    var response = await Dio().get(weatherUrl,
        options: Options(headers: {'X-Yandex-API-Key': _apiKey}));

    if (response.statusCode == 200) {
      String city = response.data['geo_object']['locality']['name'];
      String country = response.data['geo_object']['country']['name'];
      String province = response.data['geo_object']['province']['name'];
      var dataFact = response.data['fact'];
      var dataForecast = response.data['forecasts'];
      List<Weather> weatherList = [];

      for (int i = 0; 7 > i; i++) {
        int temperature = 0;
        int humidity = 0;
        int windSpeed = 0;
        int feelsLike = 0;
        String icon = 'ovc';
        String condition = '';
        String iconUrl =
            'https://yastatic.net/weather/i/icons/funky/dark/$icon.svg';
        DateTime date = DateTime.now().add(Duration(days: i));
        if (i == 0) {
          temperature = dataFact['temp'].toInt();
          humidity = dataFact['humidity'].toInt();
          windSpeed = dataFact['wind_speed'].toInt();
          feelsLike = dataFact['feels_like'].toInt();
          icon = dataFact['icon'];
          condition = dataFact['condition'];
        } else {
          var day = dataForecast[i];
          temperature = day['parts']['day_short']['temp'].toInt();
          humidity = day['parts']['day_short']['humidity'].toInt();
          windSpeed = day['parts']['day_short']['wind_speed'].toInt();
          feelsLike = day['parts']['day_short']['feels_like'].toInt();
          icon = day['parts']['day_short']['icon'];
          condition = day['parts']['day_short']['condition'];
        }

        weatherList.add(Weather(
            city: city,
            country: country,
            province: province,
            temperature: temperature,
            humidity: humidity,
            windSpeed: windSpeed,
            feelsLike: feelsLike,
            iconUrl: iconUrl,
            condition: condition,
            date: date));
      }
      return weatherList;
    } else {
      throw Exception('Ошибка получения данных о погоде');
    }
  }
}
