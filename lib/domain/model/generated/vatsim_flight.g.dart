// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../vatsim_flight.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VatsimFlight _$VatsimFlightFromJson(Map<String, dynamic> json) => VatsimFlight(
  (json['cid'] as num).toInt(),
  json['name'] as String,
  json['callsign'] as String,
  json['server'] as String,
  (json['pilot_rating'] as num).toInt(),
  (json['military_rating'] as num).toInt(),
  (json['latitude'] as num).toDouble(),
  (json['longitude'] as num).toDouble(),
  (json['altitude'] as num).toInt(),
  (json['groundspeed'] as num).toInt(),
  json['transponder'] as String,
  (json['heading'] as num).toInt(),
  (json['qnh_i_hg'] as num).toDouble(),
  (json['qnh_mb'] as num).toInt(),
  DateTime.parse(json['logon_time'] as String),
  DateTime.parse(json['last_updated'] as String),
  json['flight_plan'] == null
      ? null
      : VatsimFlightPlan.fromJson(json['flight_plan'] as Map<String, dynamic>),
);

Map<String, dynamic> _$VatsimFlightToJson(VatsimFlight instance) =>
    <String, dynamic>{
      'cid': instance.cid,
      'name': instance.name,
      'callsign': instance.callsign,
      'server': instance.server,
      'pilot_rating': instance.pilotRating,
      'military_rating': instance.militaryRating,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'altitude': instance.altitude,
      'groundspeed': instance.groundSpeed,
      'transponder': instance.transponder,
      'heading': instance.heading,
      'qnh_i_hg': instance.qnhIHg,
      'qnh_mb': instance.qnhMb,
      'logon_time': instance.logonTime.toIso8601String(),
      'last_updated': instance.lastUpdated.toIso8601String(),
      if (instance.flightPlan?.toJson() case final value?) 'flight_plan': value,
    };

VatsimFlightPlan _$VatsimFlightPlanFromJson(Map<String, dynamic> json) =>
    VatsimFlightPlan(
      json['flight_rules'] as String,
      json['aircraft'] as String,
      json['aircraft_faa'] as String,
      json['aircraft_short'] as String,
      json['departure'] as String,
      json['arrival'] as String,
      json['alternate'] as String,
      json['cruise_tas'] as String,
      json['altitude'] as String,
      json['deptime'] as String,
      json['enroute_time'] as String,
      json['fuel_time'] as String,
      json['remarks'] as String,
      json['route'] as String,
      (json['revision_id'] as num).toInt(),
      json['assigned_transponder'] as String,
    );

Map<String, dynamic> _$VatsimFlightPlanToJson(VatsimFlightPlan instance) =>
    <String, dynamic>{
      'flight_rules': instance.flightRules,
      'aircraft': instance.aircraft,
      'aircraft_faa': instance.aircraftFaa,
      'aircraft_short': instance.aircraftShort,
      'departure': instance.departure,
      'arrival': instance.arrival,
      'alternate': instance.alternate,
      'cruise_tas': instance.cruiseTas,
      'altitude': instance.altitude,
      'deptime': instance.deptime,
      'enroute_time': instance.enrouteTime,
      'fuel_time': instance.fuelTime,
      'remarks': instance.remarks,
      'route': instance.route,
      'revision_id': instance.revisionId,
      'assigned_transponder': instance.assignedTransponder,
    };
