import 'package:json_annotation/json_annotation.dart';

part 'generated/ivao_flight.g.dart';

@JsonSerializable()
class IvaoFlight {
  final int id;
  final String callsign;
  final int userId;
  final dynamic isMilitary;
  final bool isWorldTour;
  final String connectionType;
  final IvaoFlightPlan? flightPlan;
  final LastTrack? lastTrack;

  IvaoFlight(this.id, this.callsign, this.userId, this.isMilitary, this.isWorldTour, this.connectionType, this.flightPlan, this.lastTrack);

  factory IvaoFlight.fromJson(Map<String, dynamic> json) => _$IvaoFlightFromJson(json);

  Map<String, dynamic> toJson() => _$IvaoFlightToJson(this);
}

@JsonSerializable()
class IvaoFlightPlan {
  final int? id;
  final String? arrivalId;
  final String? departureId;
  final String? aircraftId;
  final IvaoAircraft? aircraft;

  IvaoFlightPlan(this.id, this.arrivalId, this.departureId, this.aircraftId, this.aircraft);

  factory IvaoFlightPlan.fromJson(Map<String, dynamic> json) => _$IvaoFlightPlanFromJson(json);

  Map<String, dynamic> toJson() => _$IvaoFlightPlanToJson(this);
}

@JsonSerializable()
class IvaoAircraft {
  final String icaoCode;
  final String model;
  final String wakeTurbulence;
  final dynamic isMilitary;
  final String description;

  IvaoAircraft(this.icaoCode, this.model, this.wakeTurbulence, this.isMilitary, this.description);

  factory IvaoAircraft.fromJson(Map<String, dynamic> json) => _$IvaoAircraftFromJson(json);

  Map<String, dynamic> toJson() => _$IvaoAircraftToJson(this);
}

@JsonSerializable()
class DepartureArrival {
  final String? icao;
  final String? iata;
  final String name;
  final dynamic city;
  final String countryId;
  final double longitude;
  final double latitude;
  final dynamic military;

  DepartureArrival(this.icao, this.iata, this.name, this.city, this.countryId, this.longitude, this.latitude, this.military);

  factory DepartureArrival.fromJson(Map<String, dynamic> json) => _$DepartureArrivalFromJson(json);

  Map<String, dynamic> toJson() => _$DepartureArrivalToJson(this);
}

@JsonSerializable()
class LastTrack {
  final int altitude;
  final int altitudeDifference;
  final double? arrivalDistance;
  final double? departureDistance;
  final int groundSpeed;
  final int heading;
  final double latitude;
  final double longitude;
  final bool onGround;
  final String state;
  final int time;
  final DateTime timestamp;
  final int transponder;
  final String transponderMode;

  LastTrack(this.altitude, this.altitudeDifference, this.arrivalDistance, this.departureDistance, this.groundSpeed, this.heading, this.latitude, this.longitude, this.onGround, this.state, this.time, this.timestamp, this.transponder, this.transponderMode);

  factory LastTrack.fromJson(Map<String, dynamic> json) => _$LastTrackFromJson(json);

  Map<String, dynamic> toJson() => _$LastTrackToJson(this);
}