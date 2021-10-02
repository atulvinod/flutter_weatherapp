import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:weatherapp/main.dart';
import 'package:weatherapp/models/location_model.dart';
import 'package:weatherapp/models/weather_model.dart';

class WeatherService {
  Future<WeatherModel> getCurrentWeather(double lat, double lon) async {
    var response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?units=metric&lat=$lat&lon=$lon&appid=${MyApp.APIKEY}'));
    var responseBody = jsonDecode(response.body);
    WeatherModel result = WeatherModel(
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

  Future<List<WeatherModel>> getHourlyForcast(double lat, double lon) async{
     var response = await http.get(Uri.parse(
        'http://pro.openweathermap.org/data/2.5/forecast/hourly?limit=10&lat=${lat}&lon=${lon}&appid=${MyApp.APIKEY}'));
    var result = (jsonDecode(response.body) as List<dynamic>).map((e) => WeatherModel(
        weatherDescription: e['weather'][0]['description'],
        iconCode: e['weather'][0]['icon'],
        feelsLike: e['main']['feels_like'],
        tempMax: e['main']['temp_max'],
        tempMin: e['main']['temp_min'],
        temperature: e['main']['temp'],
        humidity: e['main']['humidity'],
        pressure: e['main']['pressure'],
        sunrise: e['sys']['sunrise'],
        sunset: e['sys']['sunset'],
        location: LocationModel(
          name: e['name'],
          country: e['sys']['country'],
        ))).toList();
    return result;
  }
}
