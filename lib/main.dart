import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_weather_app/bloc/weather_bloc.dart';
import 'package:yandex_weather_app/ui/screens/weather_today_screen.dart';
import 'package:yandex_weather_app/ui/theme/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeData,
        home: const WeatherTodayScreen(),
      ),
    );
  }
}
