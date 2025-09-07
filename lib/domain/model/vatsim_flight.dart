import 'package:json_annotation/json_annotation.dart';

part 'generated/vatsim_flight.g.dart';

@JsonSerializable()
class VatsimFlight {
  final int cid;
  final String name;
  final String callsign;
  final String server;
  @JsonKey(name: 'pilot_rating')
  final int pilotRating;
  @JsonKey(name: 'military_rating')
  final int militaryRating;
  final double latitude;
  final double longitude;
  final int altitude;
  @JsonKey(name: 'groundspeed')
  final int groundSpeed;
  final String transponder;
  final int heading;
  @JsonKey(name: 'qnh_i_hg')
  final double qnhIHg;
  @JsonKey(name: 'qnh_mb')
  final int qnhMb;
  @JsonKey(name: 'logon_time')
  final DateTime logonTime;
  @JsonKey(name: 'last_updated')
  final DateTime lastUpdated;
  @JsonKey(name: 'flight_plan')
  final VatsimFlightPlan? flightPlan;

  VatsimFlight(this.cid, this.name, this.callsign, this.server, this.pilotRating, this.militaryRating, this.latitude, this.longitude, this.altitude, this.groundSpeed, this.transponder, this.heading, this.qnhIHg, this.qnhMb, this.logonTime, this.lastUpdated, this.flightPlan);

  factory VatsimFlight.fromJson(Map<String, dynamic> json) => _$VatsimFlightFromJson(json);

  Map<String, dynamic> toJson() => _$VatsimFlightToJson(this);
}

@JsonSerializable()
class VatsimFlightPlan {
  @JsonKey(name: 'flight_rules')
  final String flightRules;
  final String aircraft;
  @JsonKey(name: 'aircraft_faa')
  final String aircraftFaa;
  @JsonKey(name: 'aircraft_short')
  final String aircraftShort;
  final String departure;
  final String arrival;
  final String alternate;
  @JsonKey(name: 'cruise_tas')
  final String cruiseTas;
  final String altitude;
  final String deptime;
  @JsonKey(name: 'enroute_time')
  final String enrouteTime;
  @JsonKey(name: 'fuel_time')
  final String fuelTime;
  final String remarks;
  final String route;
  @JsonKey(name: 'revision_id')
  final int revisionId;
  @JsonKey(name: 'assigned_transponder')
  final String assignedTransponder;

  VatsimFlightPlan(this.flightRules, this.aircraft, this.aircraftFaa, this.aircraftShort, this.departure, this.arrival, this.alternate, this.cruiseTas, this.altitude, this.deptime, this.enrouteTime, this.fuelTime, this.remarks, this.route, this.revisionId, this.assignedTransponder);

  factory VatsimFlightPlan.fromJson(Map<String, dynamic> json) => _$VatsimFlightPlanFromJson(json);

  Map<String, dynamic> toJson() => _$VatsimFlightPlanToJson(this);
}