import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:weatherapp/main.dart';
import 'package:weatherapp/models/location_model.dart';

class LocationService {
  final int _limit = 10; 
  Future<List<LocationModel>?> findLocationViaName(String query) async{
    List<LocationModel>? locations;
    var response = await http.get(Uri.parse('http://api.openweathermap.org/geo/1.0/direct?q=$query&limit=$_limit&appid=${MyApp.APIKEY}'));
    if(response.statusCode == 200){
    var values = (jsonDecode(response.body) as List<dynamic>).map((e) => LocationModel(name: e['name'],country: e['country'],lon: e['lon'],lat: e['lat'],state: e['state']));
    locations = values.toList();
    }
    return locations;
  }

    Future<List<LocationModel>?> findLocationViaCoordinates(double lat , double lon) async{
    List<LocationModel>? locations;
    var response = await http.get(Uri.parse('http://api.openweathermap.org/geo/1.0/reverse?lat=$lat&lon=$lon&limit=$_limit&appid=${MyApp.APIKEY}'));
    if(response.statusCode == 200){
    var values = (jsonDecode(response.body) as List<dynamic>).map((e) => LocationModel(name: e['name'],country: e['country'],lon: e['lon'],lat: e['lat'],state: e['state']));
    locations = values.toList();
    }
    return locations;
  }

  Future<List<LocationModel>?> getSelfLocation() async{
    Location location = Location();
    var serviceEnabled = await location.serviceEnabled();
    if(!serviceEnabled){
      serviceEnabled = await location.requestService();
      if(!serviceEnabled){
        print('no service enabled');
        return null;
      }
    }

    var permissionGranted = await location.hasPermission();
    if(permissionGranted == PermissionStatus.denied){
      permissionGranted = await location.requestPermission();
      if(permissionGranted != PermissionStatus.granted){
        print('not granted');
        return null;
      }
    }

    var locationData = await location.getLocation();
    return await findLocationViaCoordinates(locationData.latitude!, locationData.longitude!);
  }
}