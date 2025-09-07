// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../_flights_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlightsHistory _$FlightsHistoryFromJson(Map<String, dynamic> json) =>
    FlightsHistory(
      (json['count'] as num).toInt(),
      (json['items'] as List<dynamic>)
          .map((e) => FlightHistoryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FlightsHistoryToJson(FlightsHistory instance) =>
    <String, dynamic>{
      'count': instance.count,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };
