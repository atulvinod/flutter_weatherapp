import 'package:flutter/cupertino.dart';
import 'package:weatherapp/models/location_model.dart';
import 'package:weatherapp/services/weather_service.dart';

class LocationProvider with ChangeNotifier {
  List<LocationModel> _locations = [
    LocationModel(name: 'London', state: 'State', country: 'Country'),
    LocationModel(name: 'London', state: 'State', country: 'Country'),
    LocationModel(name: 'London', state: 'State', country: 'Country'),
    LocationModel(name: 'London', state: 'State', country: 'Country'),
    LocationModel(name: 'London', state: 'State', country: 'Country'),
    LocationModel(name: 'London', state: 'State', country: 'Country'),
    LocationModel(name: 'London', state: 'State', country: 'Country'),
    LocationModel(name: 'London', state: 'State', country: 'Country'),
  ];

  final weatherService = WeatherService();

  List<LocationModel> get location => [..._locations];

  Future<void> findLocations(String query) async {
    var locations = await weatherService.findLocation(query);
    _locations
      ..clear()
      ..addAll(locations);
    notifyListeners();
  }
}
