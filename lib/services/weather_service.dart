import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherapp/models/location_model.dart';

class WeatherService {
  final String _APIKEY = 'cdafe644081dad824933fbac2b6dc013';
  final int _limit = 10; 
  Future<List<LocationModel>> findLocationViaName(String query) async{
    List<LocationModel> locations = [];
    var response = await http.get(Uri.parse('http://api.openweathermap.org/geo/1.0/direct?q=$query&limit=$_limit&appid=$_APIKEY'));
    if(response.statusCode == 200){
    var values = (jsonDecode(response.body) as List<dynamic>).map((e) => LocationModel(name: e['name'],country: e['country'],lon: e['lon'],lat: e['lat'],state: e['state']));
    locations = values.toList();
    }
    return locations;
  }

    Future<List<LocationModel>> findLocationViaCoordinates(double lat , double lon) async{
    List<LocationModel> locations = [];
    var response = await http.get(Uri.parse('http://api.openweathermap.org/geo/1.0/reverse?lat=$lat&lon=$lon&limit=$_limit&appid=$_APIKEY'));
    if(response.statusCode == 200){
    var values = (jsonDecode(response.body) as List<dynamic>).map((e) => LocationModel(name: e['name'],country: e['country'],lon: e['lon'],lat: e['lat'],state: e['state']));
    locations = values.toList();
    }
    return locations;
  }

  Future<void> getCurrentWeatherStatus() async{

  }

  Future<void> getWeeklyForecast() async {

  }
}