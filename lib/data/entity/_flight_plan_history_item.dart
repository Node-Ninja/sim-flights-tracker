import 'package:json_annotation/json_annotation.dart';

part 'generated/_flight_plan_history_item.g.dart';

@JsonSerializable()
class FlightPlanHistoryItem {
  final int id;
  final int connectionId;
  final String callSign;
  final String aircraft;
  final String cruiseSpeed;
  final String altitude;
  final String route;
  final String filed;
  final String vatsimId;
  final String flightType;
  final String departure;
  final String arrival;
  final String alternate;
  final String remarks;
  final String departureTime;
  final int hoursEnRoute;
  final int minutesEnRoute;
  final int hoursFuel;
  final int minutesFuel;
  final String assignedSquawk;

  factory FlightPlanHistoryItem.fromJson(Map<String, dynamic> json) => _$FlightPlanHistoryItemFromJson(json);

  FlightPlanHistoryItem(this.id, this.connectionId, this.callSign, this.aircraft, this.cruiseSpeed, this.altitude, this.route, this.filed, this.vatsimId, this.flightType, this.departure, this.arrival, this.alternate, this.remarks, this.departureTime, this.hoursEnRoute, this.minutesEnRoute, this.hoursFuel, this.minutesFuel, this.assignedSquawk);

  Map<String, dynamic> toJson() => _$FlightPlanHistoryItemToJson(this);

}