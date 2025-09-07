import 'package:json_annotation/json_annotation.dart';

part 'generated/_air_traffic_control_sector.g.dart';

@JsonSerializable()
class AirTrafficControlSector {
  final String icao;
  final String name;
  final String boundary;
  final bool isOceanic;
  final double lat;
  final double lon;
  final String? region;
  final String? division;
  final String? callsign;
  final SectorFeature feature;

  AirTrafficControlSector(this.icao, this.name, this.boundary, this.isOceanic, this.lat, this.lon, this.region, this.division, this.callsign, this.feature);

  factory AirTrafficControlSector.fromJson(Map<String, dynamic> json) => _$AirTrafficControlSectorFromJson(json);

  Map<String, dynamic> toJson() => _$AirTrafficControlSectorToJson(this);
}

@JsonSerializable()
class SectorFeature {
  final String type;
  final String id;
  final SectorGeometry geometry;

  SectorFeature(this.type, this.id, this.geometry);

  factory SectorFeature.fromJson(Map<String, dynamic> json) => _$SectorFeatureFromJson(json);

  Map<String, dynamic> toJson() => _$SectorFeatureToJson(this);
}

@JsonSerializable()
class SectorGeometry {
  final String type;
  final List<List<List<List<double>>>> coordinates;

  SectorGeometry(this.type, this.coordinates);

  factory SectorGeometry.fromJson(Map<String, dynamic> json) => _$SectorGeometryFromJson(json);

  Map<String, dynamic> toJson() => _$SectorGeometryToJson(this);
}