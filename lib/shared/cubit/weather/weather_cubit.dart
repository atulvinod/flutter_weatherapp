import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/main.dart';
import 'package:weatherapp/models/enums.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/screens/settings/cubit/settings_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/services/weather_service.dart';
part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final SettingsCubit settingsCubit;

  final WeatherService weatherService = WeatherService();

  WeatherCubit(this.settingsCubit) : super(WeatherInitial()) {
    settingsCubit.stream.listen((state) {
      if (state is SettingsLoading) {
        emit(WeatherLoading());
      } else if (state is SettingsLoaded) {
        getWeatherData(
            lat: state.settings.currentLat,
            lon: state.settings.currentLong,
            unit: state.settings.unit);
      }
    });
  }

  getWeatherData({double? lat, double? lon, Units? unit}) async {
    emit(WeatherLoading());
    var settings = (settingsCubit.state as SettingsLoaded).settings;
    var response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?units=${UnitsMapping[unit?.index ?? settings.unit.index]}&lat=${lat ?? settings.currentLat}&appid=${MyApp.APIKEY}&lon=${lon ?? settings.currentLong}'));
    var e = jsonDecode(response.body);
    var currentWeather = await weatherService.getCurrentWeather(
        lat ?? settings.currentLat, lon ?? settings.currentLong,
        unit: unit ?? settings.unit);
    var hourly = (e['hourly'] as List<dynamic>)
        .where((element) =>
            element['dt'] >
            DateTime.now().toUtc().microsecondsSinceEpoch * 1000000)
        .take(10)
        .map(
          (z) => WeatherModel(
              units: unit ?? settings.unit,
              temperature:
                  z['temp'] is int ? (z['temp'] as int).toDouble() : z['temp'],
              feelsLike: z['feels_like'] is int
                  ? (z['feels_like'] as int).toDouble()
                  : z['feels_like'],
              currentTime: z['dt'],
              pressure: z['pressure'],
              tempMax: z['temp_max'] is int
                  ? (z['temp_max'] as int).toDouble()
                  : z['temp_max'],
              tempMin: z['temp_min'] is int
                  ? (z['temp_min'] as int).toDouble()
                  : z['temp_min'],
              weatherDescription: z['weather'][0]['description'],
              iconCode: z['weather'][0]['icon'],
              humidity: z['humidity']),
        )
        .toList();
    var daily = (e['daily'] as List<dynamic>)
        .map(
          (z) => WeatherModel(
              units: unit ?? settings.unit,
              currentTime: z['dt'],
              temperature: z['temp']['day'],
              feelsLike: z['feels_like']['day'],
              pressure: z['pressure'],
              tempMax: z['temp']['max'] is int
                  ? (z['temp']['max'] as int).toDouble()
                  : z['temp']['max'],
              tempMin: z['temp']['min'] is int
                  ? (z['temp']['min'] as int).toDouble()
                  : z['temp']['min'],
              weatherDescription: z['weather'][0]['description'],
              iconCode: z['weather'][0]['icon'],
              humidity: z['humidity'],
              sunrise: z['sunrise'],
              sunset: z['sunset']),
        )
        .toList();
    emit(WeatherLoaded(currentWeather, hourly, daily, unit ?? settings.unit));
  }
}
