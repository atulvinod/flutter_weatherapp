import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/main.dart';
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
            lat: state.settings.currentLat, lon: state.settings.currentLong);
      }
    });
  }

  getWeatherData({double? lat, double? lon}) async {
    emit(WeatherLoading());
    var settings = (settingsCubit.state as SettingsLoaded).settings;
    var response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=${lat ?? settings.currentLat}&appid=${MyApp.APIKEY}&lon=${lon ?? settings.currentLong}'));
    var e = jsonDecode(response.body);
    var currentWeather = await weatherService.getCurrentWeather(
        lat ?? settings.currentLat, lon ?? settings.currentLong);
    var hourly = (e['hourly'] as List<dynamic>)
        .take(10)
        .map(
          (z) => WeatherModel(
              temperature: z['temp'],
              feelsLike: z['feels_like'],
              pressure: z['pressure'],
              tempMax: z['temp_max'],
              tempMin: z['temp_min'],
              weatherDescription: z['weather'][0]['description'],
              iconCode: z['weather'][0]['icon'],
              humidity: z['humidity']),
        )
        .toList();
    var daily = (e['daily'] as List<dynamic>)
        .map(
          (z) => WeatherModel(
              temperature: z['temp']['day'],
              feelsLike: z['feels_like']['day'],
              pressure: z['pressure'],
              tempMax: z['temp_max'],
              tempMin: z['temp_min'],
              weatherDescription: z['weather'][0]['description'],
              iconCode: z['weather'][0]['icon'],
              humidity: z['humidity'],
              sunrise: z['sunrise'],
              sunset: z['sunset']),
        )
        .toList();
    emit(WeatherLoaded(currentWeather, hourly, daily));
  }
}
