// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../vatsim_atis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VatsimAtis _$VatsimAtisFromJson(Map<String, dynamic> json) => VatsimAtis(
  (json['cid'] as num).toInt(),
  json['name'] as String,
  json['callsign'] as String,
  json['frequency'] as String,
  (json['facility'] as num).toInt(),
  (json['rating'] as num).toInt(),
  json['server'] as String,
  (json['visual_range'] as num).toInt(),
  json['atis_code'] as String?,
  json['last_updated'] as String,
  json['logon_time'] as String,
  (json['text_atis'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$VatsimAtisToJson(VatsimAtis instance) =>
    <String, dynamic>{
      'cid': instance.cid,
      'name': instance.name,
      'callsign': instance.callsign,
      'frequency': instance.frequency,
      'facility': instance.facility,
      'rating': instance.rating,
      'server': instance.server,
      'visual_range': instance.visualRange,
      if (instance.atisCode case final value?) 'atis_code': value,
      'last_updated': instance.lastUpdated,
      'logon_time': instance.logonTime,
      if (instance.textAtis case final value?) 'text_atis': value,
    };
