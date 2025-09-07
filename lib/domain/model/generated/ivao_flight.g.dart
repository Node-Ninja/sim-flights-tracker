// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../ivao_flight.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IvaoFlight _$IvaoFlightFromJson(Map<String, dynamic> json) => IvaoFlight(
  (json['id'] as num).toInt(),
  json['callsign'] as String,
  (json['userId'] as num).toInt(),
  json['isMilitary'],
  json['isWorldTour'] as bool,
  json['connectionType'] as String,
  json['flightPlan'] == null
      ? null
      : IvaoFlightPlan.fromJson(json['flightPlan'] as Map<String, dynamic>),
  json['lastTrack'] == null
      ? null
      : LastTrack.fromJson(json['lastTrack'] as Map<String, dynamic>),
);

Map<String, dynamic> _$IvaoFlightToJson(IvaoFlight instance) =>
    <String, dynamic>{
      'id': instance.id,
      'callsign': instance.callsign,
      'userId': instance.userId,
      if (instance.isMilitary case final value?) 'isMilitary': value,
      'isWorldTour': instance.isWorldTour,
      'connectionType': instance.connectionType,
      if (instance.flightPlan?.toJson() case final value?) 'flightPlan': value,
      if (instance.lastTrack?.toJson() case final value?) 'lastTrack': value,
    };

IvaoFlightPlan _$IvaoFlightPlanFromJson(Map<String, dynamic> json) =>
    IvaoFlightPlan(
      (json['id'] as num?)?.toInt(),
      json['arrivalId'] as String?,
      json['departureId'] as String?,
      json['aircraftId'] as String?,
      json['aircraft'] == null
          ? null
          : IvaoAircraft.fromJson(json['aircraft'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IvaoFlightPlanToJson(IvaoFlightPlan instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.arrivalId case final value?) 'arrivalId': value,
      if (instance.departureId case final value?) 'departureId': value,
      if (instance.aircraftId case final value?) 'aircraftId': value,
      if (instance.aircraft?.toJson() case final value?) 'aircraft': value,
    };

IvaoAircraft _$IvaoAircraftFromJson(Map<String, dynamic> json) => IvaoAircraft(
  json['icaoCode'] as String,
  json['model'] as String,
  json['wakeTurbulence'] as String,
  json['isMilitary'],
  json['description'] as String,
);

Map<String, dynamic> _$IvaoAircraftToJson(IvaoAircraft instance) =>
    <String, dynamic>{
      'icaoCode': instance.icaoCode,
      'model': instance.model,
      'wakeTurbulence': instance.wakeTurbulence,
      if (instance.isMilitary case final value?) 'isMilitary': value,
      'description': instance.description,
    };

DepartureArrival _$DepartureArrivalFromJson(Map<String, dynamic> json) =>
    DepartureArrival(
      json['icao'] as String?,
      json['iata'] as String?,
      json['name'] as String,
      json['city'],
      json['countryId'] as String,
      (json['longitude'] as num).toDouble(),
      (json['latitude'] as num).toDouble(),
      json['military'],
    );

Map<String, dynamic> _$DepartureArrivalToJson(DepartureArrival instance) =>
    <String, dynamic>{
      if (instance.icao case final value?) 'icao': value,
      if (instance.iata case final value?) 'iata': value,
      'name': instance.name,
      if (instance.city case final value?) 'city': value,
      'countryId': instance.countryId,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      if (instance.military case final value?) 'military': value,
    };

LastTrack _$LastTrackFromJson(Map<String, dynamic> json) => LastTrack(
  (json['altitude'] as num).toInt(),
  (json['altitudeDifference'] as num).toInt(),
  (json['arrivalDistance'] as num?)?.toDouble(),
  (json['departureDistance'] as num?)?.toDouble(),
  (json['groundSpeed'] as num).toInt(),
  (json['heading'] as num).toInt(),
  (json['latitude'] as num).toDouble(),
  (json['longitude'] as num).toDouble(),
  json['onGround'] as bool,
  json['state'] as String,
  (json['time'] as num).toInt(),
  DateTime.parse(json['timestamp'] as String),
  (json['transponder'] as num).toInt(),
  json['transponderMode'] as String,
);

Map<String, dynamic> _$LastTrackToJson(LastTrack instance) => <String, dynamic>{
  'altitude': instance.altitude,
  'altitudeDifference': instance.altitudeDifference,
  if (instance.arrivalDistance case final value?) 'arrivalDistance': value,
  if (instance.departureDistance case final value?) 'departureDistance': value,
  'groundSpeed': instance.groundSpeed,
  'heading': instance.heading,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'onGround': instance.onGround,
  'state': instance.state,
  'time': instance.time,
  'timestamp': instance.timestamp.toIso8601String(),
  'transponder': instance.transponder,
  'transponderMode': instance.transponderMode,
};
