import 'package:json_annotation/json_annotation.dart';

part 'generated/_controller.g.dart';

@JsonSerializable()
class Controller {
  final int id;
  final String name;
  final String frequency;
  final int facility;
  final String callsign;
  final String? connectionType;
  final AtcPosition? atcPosition;
  final List<String>? textAtis;
  final DateTime? logonTime;
  final int? rating;

  Controller(this.id, this.name, this.frequency, this.facility, this.callsign, this.connectionType, this.atcPosition, this.textAtis, this.logonTime, this.rating);

  factory Controller.fromJson(Map<String, dynamic> json) => _$ControllerFromJson(json);
  Map<String, dynamic> toJson() => _$ControllerToJson(this);
}

@JsonSerializable()
class AtcPosition {
  final String airportId;
  final String atcCallsign;
  final String? middleIdentifier;
  final bool? isMilitary;
  final String position;
  final String composePosition;
  final ControllerAirport airport;

  AtcPosition(this.airportId, this.atcCallsign, this.middleIdentifier, this.isMilitary, this.position, this.composePosition, this.airport);

  factory AtcPosition.fromJson(Map<String, dynamic> json) => _$AtcPositionFromJson(json);
  Map<String, dynamic> toJson() => _$AtcPositionToJson(this);
}

@JsonSerializable()
final class ControllerAirport {
  final String icao;
  final String iata;
  final String name;
  final String countryId;
  final String city;
  final double latitude;
  final double longitude;
  final bool? isMilitary;

  ControllerAirport(this.icao, this.iata, this.name, this.countryId, this.city, this.latitude, this.longitude, this.isMilitary);

  factory ControllerAirport.fromJson(Map<String, dynamic> json) => _$ControllerAirportFromJson(json);
  Map<String, dynamic> toJson() => _$ControllerAirportToJson(this);
}