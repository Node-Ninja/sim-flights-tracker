// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../_flight_track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlightTrack _$FlightTrackFromJson(Map<String, dynamic> json) => FlightTrack(
  json['callsign'] as String,
  (json['points'] as List<dynamic>)
      .map((e) => PointPosition.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$FlightTrackToJson(FlightTrack instance) =>
    <String, dynamic>{
      'callsign': instance.callsign,
      'points': instance.points.map((e) => e.toJson()).toList(),
    };

PointPosition _$PointPositionFromJson(Map<String, dynamic> json) =>
    PointPosition(
      (json['latitude'] as num).toDouble(),
      (json['longitude'] as num).toDouble(),
      (json['timestamp'] as num).toInt(),
    );

Map<String, dynamic> _$PointPositionToJson(PointPosition instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'timestamp': instance.timestamp,
    };
