import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherapp/models/location_model.dart';

class WeatherService {
  final String APIKEY = 'cdafe644081dad824933fbac2b6dc013';

  Future<List<LocationModel>> findLocation(String query) async{
    List<LocationModel> locations = [];
    var response = await http.get(Uri.parse('http://api.openweathermap.org/geo/1.0/direct?q=$query&limit=10&appid=$APIKEY'));
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