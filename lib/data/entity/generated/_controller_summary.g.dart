// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../_controller_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ControllerSummary _$ControllerSummaryFromJson(Map<String, dynamic> json) =>
    ControllerSummary(
      json['callsign'] as String,
      json['frequency'] as String,
      json['facility'] as String,
      (json['latitude'] as num?)?.toDouble(),
      (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ControllerSummaryToJson(ControllerSummary instance) =>
    <String, dynamic>{
      'callsign': instance.callsign,
      'frequency': instance.frequency,
      'facility': instance.facility,
      if (instance.latitude case final value?) 'latitude': value,
      if (instance.longitude case final value?) 'longitude': value,
    };
