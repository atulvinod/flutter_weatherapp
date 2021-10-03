import 'package:equatable/equatable.dart';

import 'package:weatherapp/models/enums.dart';

class SettingsModel extends Equatable {
  final Units unit;
  final double currentLat;
  final double currentLong;
  const SettingsModel(this.unit, this.currentLat, this.currentLong);

  @override
  List<Object?> get props => [this.unit, this.currentLat, this.currentLong];

  SettingsModel copyWith({
    Units? unit,
    double? currentLat,
    double? currentLong,
  }) {
    return SettingsModel(
      unit ?? this.unit,
      currentLat ?? this.currentLat,
      currentLong ?? this.currentLong,
    );
  }
}
