// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../_vatsim_online_fir.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VatsimOnlineFir _$VatsimOnlineFirFromJson(Map<String, dynamic> json) =>
    VatsimOnlineFir(
      json['icao'] as String,
      json['name'] as String,
      json['prefix'] as String,
      json['fir'] as String,
      json['freq'] as String,
      json['ctrName'] as String,
      json['ctrCallsign'] as String,
    );

Map<String, dynamic> _$VatsimOnlineFirToJson(VatsimOnlineFir instance) =>
    <String, dynamic>{
      'icao': instance.icao,
      'name': instance.name,
      'prefix': instance.prefix,
      'fir': instance.fir,
      'freq': instance.freq,
      'ctrName': instance.ctrName,
      'ctrCallsign': instance.ctrCallsign,
    };
