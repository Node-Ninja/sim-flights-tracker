// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../atc_sector.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AtcSector _$AtcSectorFromJson(Map<String, dynamic> json) => AtcSector(
  json['type'] as String,
  AtcSectorProperties.fromJson(json['properties'] as Map<String, dynamic>),
  Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AtcSectorToJson(AtcSector instance) => <String, dynamic>{
  'type': instance.type,
  'properties': instance.properties.toJson(),
  'geometry': instance.geometry.toJson(),
};

AtcSectorProperties _$AtcSectorPropertiesFromJson(Map<String, dynamic> json) =>
    AtcSectorProperties(
      json['id'] as String,
      json['oceanic'] as String,
      json['label_lon'] as String,
      json['label_lat'] as String,
    );

Map<String, dynamic> _$AtcSectorPropertiesToJson(
  AtcSectorProperties instance,
) => <String, dynamic>{
  'id': instance.id,
  'oceanic': instance.oceanic,
  'label_lon': instance.labelLon,
  'label_lat': instance.labelLat,
};
