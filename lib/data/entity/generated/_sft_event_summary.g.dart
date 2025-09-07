// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../_sft_event_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SftEventSummary _$SftEventSummaryFromJson(Map<String, dynamic> json) =>
    SftEventSummary(
      (json['id'] as num).toInt(),
      json['name'] as String,
      DateTime.parse(json['startTime'] as String),
      DateTime.parse(json['endTime'] as String),
      json['poster'] as String,
    );

Map<String, dynamic> _$SftEventSummaryToJson(SftEventSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'poster': instance.poster,
    };
