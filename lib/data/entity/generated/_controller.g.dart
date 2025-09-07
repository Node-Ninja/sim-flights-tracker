// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../_controller.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Controller _$ControllerFromJson(Map<String, dynamic> json) => Controller(
  (json['id'] as num).toInt(),
  json['name'] as String,
  json['frequency'] as String,
  (json['facility'] as num).toInt(),
  json['callsign'] as String,
  json['connectionType'] as String?,
  json['atcPosition'] == null
      ? null
      : AtcPosition.fromJson(json['atcPosition'] as Map<String, dynamic>),
  (json['textAtis'] as List<dynamic>?)?.map((e) => e as String).toList(),
  json['logonTime'] == null
      ? null
      : DateTime.parse(json['logonTime'] as String),
  (json['rating'] as num?)?.toInt(),
);

Map<String, dynamic> _$ControllerToJson(
  Controller instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'frequency': instance.frequency,
  'facility': instance.facility,
  'callsign': instance.callsign,
  if (instance.connectionType case final value?) 'connectionType': value,
  if (instance.atcPosition?.toJson() case final value?) 'atcPosition': value,
  if (instance.textAtis case final value?) 'textAtis': value,
  if (instance.logonTime?.toIso8601String() case final value?)
    'logonTime': value,
  if (instance.rating case final value?) 'rating': value,
};

AtcPosition _$AtcPositionFromJson(Map<String, dynamic> json) => AtcPosition(
  json['airportId'] as String,
  json['atcCallsign'] as String,
  json['middleIdentifier'] as String?,
  json['isMilitary'] as bool?,
  json['position'] as String,
  json['composePosition'] as String,
  ControllerAirport.fromJson(json['airport'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AtcPositionToJson(
  AtcPosition instance,
) => <String, dynamic>{
  'airportId': instance.airportId,
  'atcCallsign': instance.atcCallsign,
  if (instance.middleIdentifier case final value?) 'middleIdentifier': value,
  if (instance.isMilitary case final value?) 'isMilitary': value,
  'position': instance.position,
  'composePosition': instance.composePosition,
  'airport': instance.airport.toJson(),
};

ControllerAirport _$ControllerAirportFromJson(Map<String, dynamic> json) =>
    ControllerAirport(
      json['icao'] as String,
      json['iata'] as String,
      json['name'] as String,
      json['countryId'] as String,
      json['city'] as String,
      (json['latitude'] as num).toDouble(),
      (json['longitude'] as num).toDouble(),
      json['isMilitary'] as bool?,
    );

Map<String, dynamic> _$ControllerAirportToJson(ControllerAirport instance) =>
    <String, dynamic>{
      'icao': instance.icao,
      'iata': instance.iata,
      'name': instance.name,
      'countryId': instance.countryId,
      'city': instance.city,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      if (instance.isMilitary case final value?) 'isMilitary': value,
    };
