// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../_atc_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AtcHistory _$AtcHistoryFromJson(Map<String, dynamic> json) => AtcHistory(
  (json['items'] as List<dynamic>)
      .map((e) => AtcHistoryItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  (json['count'] as num).toInt(),
);

Map<String, dynamic> _$AtcHistoryToJson(AtcHistory instance) =>
    <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
      'count': instance.count,
    };
