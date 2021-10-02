class LocationModel {
  final String? name;
  final double? lat;
  final double? lon;
  final String? state;
  final String? country;

  LocationModel({
    this.name,
    this.lat,
    this.lon,
    this.state,
    this.country,
  });

  LocationModel copyWith({
    String? name,
    double? lat,
    double? lon,
    String? state,
    String? country,
  }) {
    return LocationModel(
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      state: state ?? this.state,
      country: country ?? this.country,
    );
  }
}
