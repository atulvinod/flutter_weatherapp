import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/models/enums.dart';
import 'package:weatherapp/models/settings_model.dart';
part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsLoading()) {
    getUserSettings();
  }

  Future<SettingsModel> getUserSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var savedUnits = prefs.getInt('units') ?? 0;
    var currentLat = prefs.getDouble('currentLat') ?? 28.7041;
    var currentLong = prefs.getDouble('currentLong') ?? 77.10525;
    var unit =
        Units.values.firstWhere((element) => element.index == savedUnits);
    var settings = SettingsModel(unit, currentLat, currentLong);
    emit(SettingsLoaded(settings));
    return settings;
  }

  setUserSettings(SettingsModel settings) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('units', settings.unit.index);
    prefs.setDouble('currentLong', settings.currentLong);
    prefs.setDouble('currentLat', settings.currentLat);
    emit(SettingsLoaded(SettingsModel(
        settings.unit, settings.currentLat, settings.currentLong)));
  }

  Future<void> setUserLocation(double lat, double lon) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var savedUnits = prefs.getInt('units') ?? 0;
    prefs.setDouble('currentLong', lon);
    prefs.setDouble('currentLat', lat);
    emit(SettingsLoaded(SettingsModel(
        Units.values.firstWhere((element) => element.index == savedUnits),
        lat,
        lon)));
  }
}
