
import 'package:flutter/material.dart';
import 'package:weatherapp/shared/widgets/weather_pill.dart';

class HourlyWeatherList extends StatelessWidget {
  const HourlyWeatherList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        WeatherPillWidget(),
        WeatherPillWidget(),
        WeatherPillWidget(),
        WeatherPillWidget(),
        WeatherPillWidget(),
        WeatherPillWidget(),
        WeatherPillWidget(),
        WeatherPillWidget(),
      ],
    );
  }
}
