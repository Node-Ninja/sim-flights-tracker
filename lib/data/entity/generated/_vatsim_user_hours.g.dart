// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../_vatsim_user_hours.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VatsimUserHours _$VatsimUserHoursFromJson(Map<String, dynamic> json) =>
    VatsimUserHours(
      (json['id'] as num).toInt(),
      (json['pilot'] as num).toInt(),
      (json['atc'] as num).toInt(),
      (json['admin'] as num).toInt(),
      (json['sup'] as num).toInt(),
    );

Map<String, dynamic> _$VatsimUserHoursToJson(VatsimUserHours instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pilot': instance.pilot,
      'atc': instance.atc,
      'admin': instance.admin,
      'sup': instance.sup,
    };
