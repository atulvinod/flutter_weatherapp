import 'package:weatherapp/models/enums.dart';
import 'package:weatherapp/models/location_model.dart';

class WeatherModel {
  final LocationModel? location;
  final double? temperature;
  final double? feelsLike;
  final int? humidity;
  final int? pressure;
  final String? iconCode;
  final double? tempMax;
  final double? tempMin;
  final int? sunrise;
  final int? sunset;
  final String? weatherDescription;
  final int? currentTime;
  final Units? units;
  WeatherModel(
      {
        this.units,
        this.currentTime,
        this.weatherDescription,
        this.sunrise,
      this.sunset,
      this.location,
      this.temperature,
      this.feelsLike,
      this.humidity,
      this.pressure,
      this.iconCode,
      this.tempMax,
      this.tempMin});
}
