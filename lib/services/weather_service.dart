import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weatherapp/main.dart';
import 'package:weatherapp/models/enums.dart';
import 'package:weatherapp/models/location_model.dart';
import 'package:weatherapp/models/weather_model.dart';

class WeatherService {
  Future<WeatherModel?> getCurrentWeather(double lat, double lon, {Units unit = Units.Celsius}) async {
    var response = await http.get(Uri.parse('http://api.openweathermap.org/data/2.5/weather?units=${UnitsMapping[unit.index]}&lat=$lat&lon=$lon&appid=${MyApp.APIKEY}'));

    if (response.statusCode != 200) {
      return null;
    }
    var responseBody = jsonDecode(response.body);
    WeatherModel result = WeatherModel(
        units: unit,
        weatherDescription: responseBody['weather'][0]['description'],
        iconCode: responseBody['weather'][0]['icon'],
        feelsLike: responseBody['main']['feels_like'],
        tempMax: responseBody['main']['temp_max'],
        tempMin: responseBody['main']['temp_min'],
        temperature: responseBody['main']['temp'],
        humidity: responseBody['main']['humidity'],
        pressure: responseBody['main']['pressure'],
        sunrise: responseBody['sys']['sunrise'],
        sunset: responseBody['sys']['sunset'],
        location: LocationModel(
          name: responseBody['name'],
          country: responseBody['sys']['country'],
        ));
    return result;
  }

  Future<Map<dynamic, dynamic>?> getWeatherData(double lat, double lon, {Units unit = Units.Celsius}) async {
    var response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/onecall?units=${UnitsMapping[unit.index]}&lat=${lat}&appid=${MyApp.APIKEY}&lon=${lon}'));

    if (response.statusCode != 200) {
      return null;
    }

    var weatherData = jsonDecode(response.body);
    var hourly = (weatherData['hourly'] as List<dynamic>)
        .where((element) => element['dt'] > DateTime.now().toUtc().microsecondsSinceEpoch * 1000000)
        .take(10)
        .map(
          (z) => WeatherModel(
              units: unit,
              temperature: _parseNumberToDouble(z['temp']),
              feelsLike: _parseNumberToDouble(z['Feels_like']),
              currentTime: z['dt'],
              pressure: z['pressure'],
              tempMax: _parseNumberToDouble(z['temp_max']),
              tempMin: _parseNumberToDouble(z['temp_min']),
              weatherDescription: z['weather'][0]['description'],
              iconCode: z['weather'][0]['icon'],
              humidity: z['humidity']),
        )
        .toList();
    var daily = (weatherData['daily'] as List<dynamic>)
        .map(
          (z) => WeatherModel(
              units: unit,
              currentTime: z['dt'],
              temperature: _parseNumberToDouble(z['temp']['day']),
              feelsLike: z['feels_like']['day'],
              pressure: z['pressure'],
              tempMax: _parseNumberToDouble(z['temp']['max']),
              tempMin: _parseNumberToDouble(z['temp']['min']),
              weatherDescription: z['weather'][0]['description'],
              iconCode: z['weather'][0]['icon'],
              humidity: z['humidity'],
              sunrise: z['sunrise'],
              sunset: z['sunset']),
        )
        .toList();

    return {'hourly': hourly, 'daily': daily};
  }

  _parseNumberToDouble(dynamic value) {
    return value is int ? (value as int).toDouble() : value;
  }
}
