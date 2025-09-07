import 'package:json_annotation/json_annotation.dart';

part 'generated/_sft_event_summary.g.dart';

@JsonSerializable()
class SftEventSummary {
  final int id;
  final String name;
  final DateTime startTime;
  final DateTime endTime;
  final String poster;

  SftEventSummary(this.id, this.name, this.startTime, this.endTime, this.poster);

  factory SftEventSummary.fromJson(Map<String, dynamic> json) => _$SftEventSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$SftEventSummaryToJson(this);
}