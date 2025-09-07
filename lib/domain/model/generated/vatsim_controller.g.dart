// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../vatsim_controller.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VatsimController _$VatsimControllerFromJson(Map<String, dynamic> json) =>
    VatsimController(
      (json['cid'] as num).toInt(),
      json['name'] as String,
      json['callsign'] as String,
      json['frequency'] as String,
      (json['facility'] as num).toInt(),
      (json['rating'] as num).toInt(),
      json['server'] as String,
      DateTime.parse(json['last_updated'] as String),
      DateTime.parse(json['logon_time'] as String),
      (json['text_atis'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$VatsimControllerToJson(VatsimController instance) =>
    <String, dynamic>{
      'cid': instance.cid,
      'name': instance.name,
      'callsign': instance.callsign,
      'frequency': instance.frequency,
      'facility': instance.facility,
      'rating': instance.rating,
      'server': instance.server,
      'last_updated': instance.lastUpdated.toIso8601String(),
      'logon_time': instance.logonTime.toIso8601String(),
      if (instance.textAtis case final value?) 'text_atis': value,
    };
