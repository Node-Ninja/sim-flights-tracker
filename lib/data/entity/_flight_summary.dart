import 'package:json_annotation/json_annotation.dart';

part 'generated/_flight_summary.g.dart';

@JsonSerializable()
class FlightSummary {
  final String callsign;
  final double latitude;
  final double longitude;
  final int groundspeed;
  final int altitude;
  final int heading;
  final FlightPlanSummary? flightPlan;

  FlightSummary(this.callsign, this.latitude, this.longitude, this.flightPlan, this.groundspeed, this.altitude, this.heading);

  factory FlightSummary.fromJson(Map<String, dynamic> json) => _$FlightSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$FlightSummaryToJson(this);
}

@JsonSerializable()
class FlightPlanSummary {
  final String departure;
  final String arrival;

  FlightPlanSummary(this.departure, this.arrival);

  factory FlightPlanSummary.fromJson(Map<String, dynamic> json) => _$FlightPlanSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$FlightPlanSummaryToJson(this);
}