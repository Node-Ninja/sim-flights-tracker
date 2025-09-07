import 'package:json_annotation/json_annotation.dart';

part 'generated/atc_sector.g.dart';

@JsonSerializable()
class AtcSector {
  final String type;
  final AtcSectorProperties properties;
  final Geometry geometry;

  AtcSector(this.type, this.properties, this.geometry);

  factory AtcSector.fromJson(Map<String, dynamic> json) => _$AtcSectorFromJson(json);

  Map<String, dynamic> toJson() => _$AtcSectorToJson(this);
}



@JsonSerializable()
class AtcSectorProperties {
  final String id;
  final String oceanic;
  @JsonKey(name: 'label_lon')
  final String labelLon;
  @JsonKey(name: 'label_lat')
  final String labelLat;

  AtcSectorProperties(this.id, this.oceanic, this.labelLon, this.labelLat);

  factory AtcSectorProperties.fromJson(Map<String, dynamic> json) => _$AtcSectorPropertiesFromJson(json);

  Map<String, dynamic> toJson() => _$AtcSectorPropertiesToJson(this);
}

class Geometry {
  String type;
  List<List<List<List<double>>>> coordinates;

  Geometry(this.type, this.coordinates);

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    json['type'],
    List<List<List<List<double>>>>.from(json['coordinates'].map((x) => List<List<List<double>>>.from(x.map((x) => List<List<double>>.from(x.map((x) => List<double>.from(x.map((x) => x.toDouble())))))))),
  );

  Map<String, dynamic> toJson() => {};
}