import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/models/enums.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/screens/settings/cubit/settings_cubit.dart';
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
        getWeatherData(lat: state.settings.currentLat, lon: state.settings.currentLong, unit: state.settings.unit);
      }
    });
  }

  getWeatherData({double? lat, double? lon, Units? unit}) async {
    emit(WeatherLoading());
    var settings = (settingsCubit.state as SettingsLoaded).settings;

    var currentWeather = await weatherService.getCurrentWeather(lat ?? settings.currentLat, lon ?? settings.currentLong, unit: unit ?? settings.unit);
    var weatherData = await weatherService.getWeatherData(lat ?? settings.currentLat, lon ?? settings.currentLong, unit: unit ?? settings.unit);
    if (currentWeather != null && weatherData != null) {
      emit(WeatherLoaded(currentWeather, weatherData!['hourly'], weatherData!['daily'], unit ?? settings.unit));
    } else {
      emit(WeatherLoadError());
    }
  }
}
