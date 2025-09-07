// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../_airline.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Airline _$AirlineFromJson(Map<String, dynamic> json) => Airline(
  json['active'] as String,
  json['id'] as String,
  json['name'] as String,
  json['alias'] as String,
  json['iata'] as String,
  json['icao'] as String,
  json['callsign'] as String,
  json['country'] as String,
  hasCustomLogo: json['hasCustomLogo'] as bool? ?? false,
  isVirtual: json['isVirtual'] as bool? ?? false,
);

Map<String, dynamic> _$AirlineToJson(Airline instance) => <String, dynamic>{
  'active': instance.active,
  'id': instance.id,
  'name': instance.name,
  'alias': instance.alias,
  'iata': instance.iata,
  'icao': instance.icao,
  'callsign': instance.callsign,
  'country': instance.country,
  'hasCustomLogo': instance.hasCustomLogo,
  'isVirtual': instance.isVirtual,
};
