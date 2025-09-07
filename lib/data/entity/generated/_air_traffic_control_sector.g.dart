// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../_air_traffic_control_sector.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirTrafficControlSector _$AirTrafficControlSectorFromJson(
  Map<String, dynamic> json,
) => AirTrafficControlSector(
  json['icao'] as String,
  json['name'] as String,
  json['boundary'] as String,
  json['isOceanic'] as bool,
  (json['lat'] as num).toDouble(),
  (json['lon'] as num).toDouble(),
  json['region'] as String?,
  json['division'] as String?,
  json['callsign'] as String?,
  SectorFeature.fromJson(json['feature'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AirTrafficControlSectorToJson(
  AirTrafficControlSector instance,
) => <String, dynamic>{
  'icao': instance.icao,
  'name': instance.name,
  'boundary': instance.boundary,
  'isOceanic': instance.isOceanic,
  'lat': instance.lat,
  'lon': instance.lon,
  if (instance.region case final value?) 'region': value,
  if (instance.division case final value?) 'division': value,
  if (instance.callsign case final value?) 'callsign': value,
  'feature': instance.feature.toJson(),
};

SectorFeature _$SectorFeatureFromJson(Map<String, dynamic> json) =>
    SectorFeature(
      json['type'] as String,
      json['id'] as String,
      SectorGeometry.fromJson(json['geometry'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SectorFeatureToJson(SectorFeature instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'geometry': instance.geometry.toJson(),
    };

SectorGeometry _$SectorGeometryFromJson(Map<String, dynamic> json) =>
    SectorGeometry(
      json['type'] as String,
      (json['coordinates'] as List<dynamic>)
          .map(
            (e) =>
                (e as List<dynamic>)
                    .map(
                      (e) =>
                          (e as List<dynamic>)
                              .map(
                                (e) =>
                                    (e as List<dynamic>)
                                        .map((e) => (e as num).toDouble())
                                        .toList(),
                              )
                              .toList(),
                    )
                    .toList(),
          )
          .toList(),
    );

Map<String, dynamic> _$SectorGeometryToJson(SectorGeometry instance) =>
    <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
    };
