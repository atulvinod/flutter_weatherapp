import 'package:weatherapp/models/enums.dart';

class SettingsModel{
  final Units unit;
  final double currentLat;
  final double currentLong;
  SettingsModel(this.unit, this.currentLat, this.currentLong);
}