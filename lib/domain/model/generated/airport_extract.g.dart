// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../airport_extract.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirportExtract _$AirportExtractFromJson(Map<String, dynamic> json) =>
    AirportExtract(
      json['ident'] as String,
      json['name'] as String,
      json['latitude_deg'] as String,
      json['longitude_deg'] as String,
      json['gps_code'] as String,
    );

Map<String, dynamic> _$AirportExtractToJson(AirportExtract instance) =>
    <String, dynamic>{
      'ident': instance.identification,
      'name': instance.name,
      'latitude_deg': instance.latitudeDeg,
      'longitude_deg': instance.longitudeDeg,
      'gps_code': instance.gpsCode,
    };
