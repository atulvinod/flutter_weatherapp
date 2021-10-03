part of 'choose_location_cubit.dart';

abstract class ChooseLocationState extends Equatable {}

class LocationsLoaded extends ChooseLocationState {
  final List<LocationModel> locations;

  LocationsLoaded(this.locations);

  @override
  List<Object?> get props => [locations];
}

class LocationsLoading extends ChooseLocationState {
  @override
  List<Object?> get props => [];
}

class LocationsInitial extends ChooseLocationState {
  @override
  List<Object?> get props => [];
}

class LocationNotFound extends ChooseLocationState {
  @override
  List<Object?> get props => [];
}

class LocationPermissionDenied extends ChooseLocationState {
  @override
  List<Object?> get props => [];
}
