// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../_flight.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Flight _$FlightFromJson(Map<String, dynamic> json) => Flight(
  (json['id'] as num).toInt(),
  json['pilotName'] as String,
  json['callsign'] as String,
  (json['latitude'] as num).toDouble(),
  (json['longitude'] as num).toDouble(),
  (json['altitude'] as num).toInt(),
  (json['heading'] as num).toInt(),
  (json['groundSpeed'] as num).toInt(),
  json['transponder'] as String,
  json['flightPlan'] == null
      ? null
      : FlightPlan.fromJson(json['flightPlan'] as Map<String, dynamic>),
);

Map<String, dynamic> _$FlightToJson(Flight instance) => <String, dynamic>{
  'id': instance.id,
  'pilotName': instance.pilotName,
  'callsign': instance.callsign,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'altitude': instance.altitude,
  'heading': instance.heading,
  'groundSpeed': instance.groundSpeed,
  'transponder': instance.transponder,
  if (instance.flightPlan?.toJson() case final value?) 'flightPlan': value,
};

FlightPlan _$FlightPlanFromJson(Map<String, dynamic> json) => FlightPlan(
  json['departure'] as String?,
  json['arrival'] as String?,
  json['alternate'] as String,
  json['altitude'] as String,
  json['aircraftFaa'] as String,
  json['aircraftShort'] as String,
  json['route'] as String,
);

Map<String, dynamic> _$FlightPlanToJson(FlightPlan instance) =>
    <String, dynamic>{
      if (instance.departure case final value?) 'departure': value,
      if (instance.arrival case final value?) 'arrival': value,
      'alternate': instance.alternate,
      'altitude': instance.altitude,
      'aircraftFaa': instance.aircraftFaa,
      'aircraftShort': instance.aircraftShort,
      'route': instance.route,
    };
