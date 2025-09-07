// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../_aircraft.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Aircraft _$AircraftFromJson(Map<String, dynamic> json) => Aircraft(
  json['icaoCode'] as String,
  json['iataCode'] as String?,
  json['description'] as String,
  json['model'] as String,
  (json['numberEngines'] as num).toInt(),
  json['manufacture'] as String,
  json['isMilitary'] as bool,
);

Map<String, dynamic> _$AircraftToJson(Aircraft instance) => <String, dynamic>{
  'icaoCode': instance.icaoCode,
  if (instance.iataCode case final value?) 'iataCode': value,
  'description': instance.description,
  'model': instance.model,
  'numberEngines': instance.numberEngines,
  'manufacture': instance.manufacture,
  'isMilitary': instance.isMilitary,
};
