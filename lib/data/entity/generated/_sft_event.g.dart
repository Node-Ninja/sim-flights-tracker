// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../_sft_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SftEvent _$SftEventFromJson(Map<String, dynamic> json) => SftEvent(
  json['id'] as num,
  json['type'] as String,
  json['name'] as String,
  json['link'] as String,
  (json['organisers'] as List<dynamic>)
      .map((e) => EventOrganizer.fromJson(e as Map<String, dynamic>))
      .toList(),
  (json['airports'] as List<dynamic>)
      .map((e) => PartakingAirport.fromJson(e as Map<String, dynamic>))
      .toList(),
  (json['routes'] as List<dynamic>)
      .map((e) => EventRoute.fromJson(e as Map<String, dynamic>))
      .toList(),
  json['start_time'] as String,
  json['end_time'] as String,
  json['short_description'] as String,
  json['description'] as String,
  json['banner'] as String,
);

Map<String, dynamic> _$SftEventToJson(SftEvent instance) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'name': instance.name,
  'link': instance.link,
  'organisers': instance.organisers.map((e) => e.toJson()).toList(),
  'airports': instance.airports.map((e) => e.toJson()).toList(),
  'routes': instance.routes.map((e) => e.toJson()).toList(),
  'start_time': instance.startTime,
  'end_time': instance.endTime,
  'short_description': instance.shortDescription,
  'description': instance.description,
  'banner': instance.banner,
};

EventOrganizer _$EventOrganizerFromJson(Map<String, dynamic> json) =>
    EventOrganizer(
      json['region'] as String?,
      json['division'] as String?,
      json['subdivision'] as String?,
      json['organised_by_vatsim'] as bool?,
    );

Map<String, dynamic> _$EventOrganizerToJson(EventOrganizer instance) =>
    <String, dynamic>{
      if (instance.region case final value?) 'region': value,
      if (instance.division case final value?) 'division': value,
      if (instance.subdivision case final value?) 'subdivision': value,
      if (instance.organizedByVatsim case final value?)
        'organised_by_vatsim': value,
    };

PartakingAirport _$PartakingAirportFromJson(Map<String, dynamic> json) =>
    PartakingAirport(json['icao'] as String);

Map<String, dynamic> _$PartakingAirportToJson(PartakingAirport instance) =>
    <String, dynamic>{'icao': instance.icao};

EventRoute _$EventRouteFromJson(Map<String, dynamic> json) => EventRoute(
  json['departure'] as String,
  json['arrival'] as String,
  json['route'] as String,
);

Map<String, dynamic> _$EventRouteToJson(EventRoute instance) =>
    <String, dynamic>{
      'departure': instance.departure,
      'arrival': instance.arrival,
      'route': instance.route,
    };
