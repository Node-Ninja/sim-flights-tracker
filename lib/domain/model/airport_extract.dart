import 'package:json_annotation/json_annotation.dart';

part 'generated/airport_extract.g.dart';

@JsonSerializable()
class AirportExtract {
  @JsonKey(name: 'ident')
  final String identification;
  final String name;
  @JsonKey(name: 'latitude_deg')
  final String latitudeDeg;
  @JsonKey(name: 'longitude_deg')
  final String longitudeDeg;
  @JsonKey(name: 'gps_code')
  final String gpsCode;

  AirportExtract(this.identification, this.name, this.latitudeDeg, this.longitudeDeg, this.gpsCode);

  factory AirportExtract.fromJson(Map<String, dynamic> json) => _$AirportExtractFromJson(json);

  Map<String, dynamic> toJson() => _$AirportExtractToJson(this);
}