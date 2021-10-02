import 'dart:convert';

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
}
