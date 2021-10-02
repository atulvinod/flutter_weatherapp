part of 'weather_cubit.dart';

abstract class WeatherState extends Equatable {}

class WeatherInitial extends WeatherState {
  @override
  List<Object?> get props => [];
}

class WeatherLoading extends WeatherState {
  @override
  List<Object?> get props => [];
}

class WeatherLoaded extends WeatherState {
  final WeatherModel currentWeather;
  final List<WeatherModel> hourlyForcast;
  final List<WeatherModel> weeklyForecast;

  WeatherLoaded(this.currentWeather, this.hourlyForcast, this.weeklyForecast);
  @override
  List<Object?> get props => [currentWeather, hourlyForcast, weeklyForecast];
}
