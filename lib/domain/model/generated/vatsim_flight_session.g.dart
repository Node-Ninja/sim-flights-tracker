// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../vatsim_flight_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VatsimFlightSession _$VatsimFlightSessionFromJson(Map<String, dynamic> json) =>
    VatsimFlightSession(
      json['id'] as num,
      json['vatsim_id'] as String,
      (json['type'] as num).toInt(),
      (json['rating'] as num).toInt(),
      json['callsign'] as String,
      json['start'] as String,
      json['end'] as String,
      json['server'] as String,
    );

Map<String, dynamic> _$VatsimFlightSessionToJson(
  VatsimFlightSession instance,
) => <String, dynamic>{
  'id': instance.id,
  'vatsim_id': instance.vatsimId,
  'type': instance.type,
  'rating': instance.rating,
  'callsign': instance.callsign,
  'start': instance.start,
  'end': instance.end,
  'server': instance.server,
};
