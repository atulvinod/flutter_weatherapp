import 'package:flutter/cupertino.dart';
import 'package:location/location.dart' ;
import 'package:weatherapp/models/location_model.dart';
import 'package:weatherapp/services/weather_service.dart';

class LocationProvider with ChangeNotifier {
  List<LocationModel> _locations = [];

  final weatherService = WeatherService();

  List<LocationModel> get location => [..._locations];

  Future<void> findLocations(String query) async {
    var locations = await weatherService.findLocationViaName(query);
    _locations
      ..clear()
      ..addAll(locations);
    notifyListeners();
  }

  Future<void> findLocation(double lat, double lng) async{

  }

  Future<void> getSelfLocation() async{
    Location location = Location();
    var serviceEnabled = await location.serviceEnabled();
    if(!serviceEnabled){
      serviceEnabled = await location.requestService();
      if(!serviceEnabled){
        print('no service enabled');
        return;
      }
    }

    var permissionGranted = await location.hasPermission();
    if(permissionGranted == PermissionStatus.denied){
      permissionGranted = await location.requestPermission();
      if(permissionGranted != PermissionStatus.granted){
        print('not granted');
        return;
      }
    }

    var locationData = await location.getLocation();
    getWeatherFromCoordinates(locationData.latitude!, locationData.longitude!);
  }

  Future<void> getWeatherFromCoordinates(double lat, double lon) async{
   var locations = await weatherService.findLocationViaCoordinates(lat, lon);
    _locations
      ..clear()
      ..addAll(locations);
    notifyListeners();
  }
}
