import 'package:json_annotation/json_annotation.dart';

part 'generated/_flight.g.dart';

@JsonSerializable()
class Flight {
  final int id;
  final String pilotName;
  final String callsign;
  final double latitude;
  final double longitude;
  final int altitude;
  final int heading;
  final int groundSpeed;
  final String transponder;
  final FlightPlan? flightPlan;

  Flight(this.id, this.pilotName, this.callsign, this.latitude, this.longitude, this.altitude, this.heading, this.groundSpeed, this.transponder, this.flightPlan);

  factory Flight.fromJson(Map<String, dynamic> json) => _$FlightFromJson(json);

  Map<String, dynamic> toJson() => _$FlightToJson(this);
}

@JsonSerializable()
class FlightPlan {
  final String? departure;
  final String? arrival;
  final String alternate;
  final String altitude;
  final String aircraftFaa;
  final String aircraftShort;
  final String route;

  FlightPlan(this.departure, this.arrival, this.alternate, this.altitude, this.aircraftFaa, this.aircraftShort, this.route);

  factory FlightPlan.fromJson(Map<String, dynamic> json) => _$FlightPlanFromJson(json);

  Map<String, dynamic> toJson() => _$FlightPlanToJson(this);

}