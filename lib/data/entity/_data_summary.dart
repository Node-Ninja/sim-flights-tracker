import 'package:json_annotation/json_annotation.dart';

import '_controller_summary.dart';
import '_flight_summary.dart';

part 'generated/_data_summary.g.dart';

@JsonSerializable()
class DataSummary {
  final List<FlightSummary> flights;
  final List<ControllerSummary> controllers;

  DataSummary(this.flights, this.controllers);

  factory DataSummary.fromJson(Map<String, dynamic> json) => _$DataSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$DataSummaryToJson(this);
}