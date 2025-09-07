// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../_flight_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlightSummary _$FlightSummaryFromJson(Map<String, dynamic> json) =>
    FlightSummary(
      json['callsign'] as String,
      (json['latitude'] as num).toDouble(),
      (json['longitude'] as num).toDouble(),
      json['flightPlan'] == null
          ? null
          : FlightPlanSummary.fromJson(
            json['flightPlan'] as Map<String, dynamic>,
          ),
      (json['groundspeed'] as num).toInt(),
      (json['altitude'] as num).toInt(),
      (json['heading'] as num).toInt(),
    );

Map<String, dynamic> _$FlightSummaryToJson(FlightSummary instance) =>
    <String, dynamic>{
      'callsign': instance.callsign,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'groundspeed': instance.groundspeed,
      'altitude': instance.altitude,
      'heading': instance.heading,
      if (instance.flightPlan?.toJson() case final value?) 'flightPlan': value,
    };

FlightPlanSummary _$FlightPlanSummaryFromJson(Map<String, dynamic> json) =>
    FlightPlanSummary(json['departure'] as String, json['arrival'] as String);

Map<String, dynamic> _$FlightPlanSummaryToJson(FlightPlanSummary instance) =>
    <String, dynamic>{
      'departure': instance.departure,
      'arrival': instance.arrival,
    };
