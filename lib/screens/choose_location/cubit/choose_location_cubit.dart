import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/models/location_model.dart';
import 'package:weatherapp/services/location_service.dart';
part 'choose_location_state.dart';

class ChooseLocationCubit extends Cubit<ChooseLocationState>{

  final LocationService _locationService = LocationService();

  ChooseLocationCubit() : super(LocationsInitial());


  Future<void> findLocations(String query) async{
    emit(LocationsLoading());
    var locations = await _locationService.findLocationViaName(query);
    if(locations == null){
      emit(LocationNotFound());
    }else{
      emit(LocationsLoaded(locations));
    }
  }

  Future<void> findCurrentLocation() async {
    emit(LocationsLoading());
    var locations = await _locationService.getSelfLocation();
    if(locations == null){
      emit(LocationNotFound());
    }else{
      emit(LocationsLoaded(locations));
    }
  }
}