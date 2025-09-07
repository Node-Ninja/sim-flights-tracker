// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../_flight_history_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlightHistoryItem _$FlightHistoryItemFromJson(Map<String, dynamic> json) =>
    FlightHistoryItem(
      (json['id'] as num).toInt(),
      (json['type'] as num).toInt(),
      (json['rating'] as num).toInt(),
      json['callsign'] as String,
      DateTime.parse(json['start'] as String),
      json['end'] == null ? null : DateTime.parse(json['end'] as String),
      json['server'] as String,
    );

Map<String, dynamic> _$FlightHistoryItemToJson(FlightHistoryItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'rating': instance.rating,
      'callsign': instance.callsign,
      'start': instance.start.toIso8601String(),
      if (instance.end?.toIso8601String() case final value?) 'end': value,
      'server': instance.server,
    };
