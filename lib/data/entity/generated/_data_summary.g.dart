// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../_data_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataSummary _$DataSummaryFromJson(Map<String, dynamic> json) => DataSummary(
  (json['flights'] as List<dynamic>)
      .map((e) => FlightSummary.fromJson(e as Map<String, dynamic>))
      .toList(),
  (json['controllers'] as List<dynamic>)
      .map((e) => ControllerSummary.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DataSummaryToJson(DataSummary instance) =>
    <String, dynamic>{
      'flights': instance.flights.map((e) => e.toJson()).toList(),
      'controllers': instance.controllers.map((e) => e.toJson()).toList(),
    };
