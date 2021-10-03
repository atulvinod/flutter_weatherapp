import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:weatherapp/models/location_model.dart';
import 'package:weatherapp/services/location_service.dart';
part 'choose_location_state.dart';

class ChooseLocationCubit extends Cubit<ChooseLocationState> {
  final LocationService _locationService = LocationService();

  ChooseLocationCubit() : super(LocationsInitial());

  Future<void> findLocations(String query) async {
    emit(LocationsLoading());
    var locations = await _locationService.findLocationViaName(query);
    if (locations == null) {
      emit(LocationNotFound());
    } else {
      emit(LocationsLoaded(locations));
    }
  }

  Future<void> findCurrentLocation() async {
    Location location = Location();
    var serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        emit(LocationPermissionDenied());
        return null;
      }
    }

    var permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        emit(LocationPermissionDenied());
        return null;
      }
    }

    var locationData = await location.getLocation();
    var locations = await _locationService.findLocationViaCoordinates(
        locationData.latitude!, locationData.longitude!);
    if (locations == null) {
      emit(LocationNotFound());
    } else {
      emit(LocationsLoaded(locations));
    }
  }
}
