import 'package:json_annotation/json_annotation.dart';

part 'generated/_flight_history_item.g.dart';

@JsonSerializable()
class FlightHistoryItem {
  final int id;
  final int type;
  final int rating;
  final String callsign;
  final DateTime start;
  final DateTime? end;
  final String server;

  factory FlightHistoryItem.fromJson(Map<String, dynamic> json) => _$FlightHistoryItemFromJson(json);

  FlightHistoryItem(this.id, this.type, this.rating, this.callsign, this.start, this.end, this.server);

  Map<String, dynamic> toJson() => _$FlightHistoryItemToJson(this);

}