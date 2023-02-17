import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yandex_weather_app/bloc/weather_bloc.dart';
import 'package:yandex_weather_app/models/weather.dart';
import 'package:yandex_weather_app/ui/theme/theme.dart';

class WeatherForecastScreen extends StatelessWidget {
  const WeatherForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<WeatherBloc>();

    return BlocConsumer<WeatherBloc, WeatherState>(
      listener: (context, state) {
        if (state is WeatherToday) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                  title: Text(state is WeatherForecast
                      ? state.weatherList[0].city
                      : ''),
                  centerTitle: true,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      if (state is WeatherForecast) {
                        bloc.add(WeatherTodayOpened(
                          weatherList: state.weatherList,
                        ));
                      }
                    },
                  )),
              body: Column(
                children: state is WeatherForecast
                    ? [
                        for (var weather in state.sortedWeatherList)
                          Column(children: [
                            _InfoRowWidget(weather: weather),
                            const Divider(
                              thickness: 1.5,
                              color: AppColors.primaryDark,
                            ),
                          ])
                      ]
                    : [],
              ),
            );
          },
        );
      },
    );
  }
}

class _InfoRowWidget extends StatelessWidget {
  const _InfoRowWidget({Key? key, required this.weather}) : super(key: key);

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(weather.dateString, style: TxtStyles.bodyText),
          const Spacer(),
          SvgPicture.network(
            weather.iconUrl,
            height: 70,
            width: 70,
            placeholderBuilder: (context) => const SizedBox.shrink(),
          ),
          const SizedBox(width: 10),
          Text('${weather.temperature}°', style: TxtStyles.bodyText),
        ],
      ),
    );
  }
}
