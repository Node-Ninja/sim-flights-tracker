import 'package:json_annotation/json_annotation.dart';
import 'package:sim_flights_tracker/data/entity/_flight_history_item.dart';

part 'generated/_flights_history.g.dart';

@JsonSerializable()
class FlightsHistory {
  final int count;
  final List<FlightHistoryItem> items;

  const FlightsHistory(this.count, this.items);

  factory FlightsHistory.fromJson(Map<String, dynamic> json) => _$FlightsHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$FlightsHistoryToJson(this);
}