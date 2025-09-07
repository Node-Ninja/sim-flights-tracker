
import 'package:json_annotation/json_annotation.dart';

part 'generated/_airline.g.dart';

@JsonSerializable()
class Airline {
  final String active;
  final String id;
  final String name;
  final String alias;
  final String iata;
  final String icao;
  final String callsign;
  final String country;
  final bool hasCustomLogo;
  final bool isVirtual;

  Airline(this.active, this.id, this.name, this.alias, this.iata, this.icao, this.callsign, this.country, {this.hasCustomLogo = false, this.isVirtual = false});

  factory Airline.fromJson(Map<String, dynamic> json) => _$AirlineFromJson(json);

  Map<String, dynamic> toJson() => _$AirlineToJson(this);
}