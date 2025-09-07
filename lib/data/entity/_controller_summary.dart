import 'package:json_annotation/json_annotation.dart';

part 'generated/_controller_summary.g.dart';

@JsonSerializable()
class ControllerSummary {
  final String callsign;
  final String frequency;
  final String facility;
  final double? latitude;
  final double? longitude;

  ControllerSummary(this.callsign, this.frequency, this.facility, this.latitude, this.longitude);

  factory ControllerSummary.fromJson(Map<String, dynamic> json) => _$ControllerSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$ControllerSummaryToJson(this);
}