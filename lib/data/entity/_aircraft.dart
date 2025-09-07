import 'package:json_annotation/json_annotation.dart';

part 'generated/_aircraft.g.dart';


@JsonSerializable()
class Aircraft {
  final String icaoCode;
  final String? iataCode;
  final String description;
  final String model;
  final int numberEngines;
  final String manufacture;
  final bool isMilitary;

  factory Aircraft.fromJson(Map<String, dynamic> json) => _$AircraftFromJson(json);

  Aircraft(this.icaoCode, this.iataCode, this.description, this.model, this.numberEngines, this.manufacture, this.isMilitary);

  Map<String, dynamic> toJson() => _$AircraftToJson(this);
}