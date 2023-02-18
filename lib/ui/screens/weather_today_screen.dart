// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yandex_weather_app/bloc/weather_bloc.dart';
import 'package:yandex_weather_app/models/location.dart';
import 'package:yandex_weather_app/models/weather.dart';
import 'package:yandex_weather_app/ui/constants/consts.dart';
import 'package:yandex_weather_app/ui/screens/weather_forecast_screen.dart';
import 'package:yandex_weather_app/ui/theme/theme.dart';

class WeatherTodayScreen extends StatefulWidget {
  const WeatherTodayScreen({super.key});

  @override
  State<WeatherTodayScreen> createState() => _WeatherTodayScreenState();
}

class _WeatherTodayScreenState extends State<WeatherTodayScreen> {
  @override
  void initState() {
    super.initState();
    _initPermission().ignore();
  }

  Future<void> _initPermission() async {
    if (!await LocationService().checkPermission()) {
      await LocationService().requestPermission();
    }
    context.read<WeatherBloc>().add(WeatherFetching());
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<WeatherBloc>();

    return BlocConsumer<WeatherBloc, WeatherState>(
      listener: (context, state) {
        if (state is WeatherForecast) {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => const WeatherForecastScreen()),
          );
        } else if (state is WeatherFetchingFailure) {
          _showErrorSnack(context);
        }
      },
      buildWhen: (previous, state) => state is WeatherToday,
      builder: (context, state) {
        return BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () {
                        if (state is WeatherToday) {
                          bloc.add(WeatherForecastOpened(
                              weatherList: state.weatherList));
                        }
                      },
                      icon: const Icon(Icons.arrow_forward))
                ],
              ),
              body: state is WeatherToday
                  ? _WeatherTodayColumn(state: state)
                  : const Center(child: CircularProgressIndicator()),
            );
          },
        );
      },
    );
  }

  /// Показывает [SnackBar] с ошибкой.
  void _showErrorSnack(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.error, color: Colors.red),
              Text(' Ошибка получения данных'),
            ],
          ),
        ),
      );
  }
}

class _WeatherTodayColumn extends StatelessWidget {
  final WeatherToday state;
  const _WeatherTodayColumn({Key? key, required this.state}) : super(key: key);

  String conditionRu(String condition) {
    const conditions = Constant.conditions;
    for (var i = 0; conditions.length > i; i++) {
      if (condition == conditions.keys.toList()[i]) {
        return conditions.values.toList()[i];
      }
    }
    return condition;
  }

  @override
  Widget build(BuildContext context) {
    Weather today = state.weatherList[0];

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${today.country}, ${today.province}',
              style: TxtStyles.orangeTextSmall),
          Flexible(
              flex: 1, child: Text(today.city, style: TxtStyles.orangeText)),
          Flexible(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      today.temperature.isNegative
                          ? '${today.temperature}°'
                          : '+${today.temperature}°',
                      style: TxtStyles.tempMain,
                    ),
                    SvgPicture.network(
                      today.iconUrl,
                      height: 140,
                      width: 140,
                      placeholderBuilder: (context) => const SizedBox.shrink(),
                    ),
                  ],
                ),
                Text(conditionRu(today.condition), style: TxtStyles.inputText),
                Text(
                    today.feelsLike.isNegative
                        ? 'Ощущается как ${today.feelsLike}°'
                        : 'Ощущается как +${today.feelsLike}°',
                    style: TxtStyles.inputText),
                const SizedBox(height: 10),
                const SizedBox(height: 10),
                _InfoRow(
                  icon: Icons.air,
                  text: '${today.windSpeed} м/с',
                ),
                _InfoRow(
                  icon: Icons.water_drop,
                  text: '${today.humidity} %',
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoRow({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.redContent),
          const SizedBox(width: 10),
          Text(text, style: TxtStyles.bodyText),
        ],
      ),
    );
  }
}
