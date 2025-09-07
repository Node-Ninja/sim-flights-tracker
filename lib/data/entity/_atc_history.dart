import 'package:json_annotation/json_annotation.dart';
import 'package:sim_flights_tracker/data/entity/_atc_history_item.dart';

part 'generated/_atc_history.g.dart';

@JsonSerializable()
class AtcHistory {
  final List<AtcHistoryItem> items;
  final int count;

  const AtcHistory(this.items, this.count);
  factory AtcHistory.fromJson(Map<String, dynamic> json) => _$AtcHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$AtcHistoryToJson(this);
}