// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../_atc_history_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AtcHistoryItem _$AtcHistoryItemFromJson(Map<String, dynamic> json) =>
    AtcHistoryItem(
      ConnectionDetails.fromJson(json['connection'] as Map<String, dynamic>),
      (json['aircrafttracked'] as num).toInt(),
      (json['aircraftseen'] as num).toInt(),
      (json['flightsamended'] as num).toInt(),
      (json['handoffsinitiated'] as num).toInt(),
      (json['handoffsreceived'] as num).toInt(),
      (json['handoffsrefused'] as num).toInt(),
      (json['squawksassigned'] as num).toInt(),
      (json['cruisealtsmodified'] as num).toInt(),
      (json['tempaltsmodified'] as num).toInt(),
      (json['scratchpadmods'] as num).toInt(),
    );

Map<String, dynamic> _$AtcHistoryItemToJson(AtcHistoryItem instance) =>
    <String, dynamic>{
      'connection': instance.connection.toJson(),
      'aircrafttracked': instance.aircrafttracked,
      'aircraftseen': instance.aircraftseen,
      'flightsamended': instance.flightsamended,
      'handoffsinitiated': instance.handoffsinitiated,
      'handoffsreceived': instance.handoffsreceived,
      'handoffsrefused': instance.handoffsrefused,
      'squawksassigned': instance.squawksassigned,
      'cruisealtsmodified': instance.cruisealtsmodified,
      'tempaltsmodified': instance.tempaltsmodified,
      'scratchpadmods': instance.scratchpadmods,
    };

ConnectionDetails _$ConnectionDetailsFromJson(Map<String, dynamic> json) =>
    ConnectionDetails(
      (json['id'] as num).toInt(),
      json['vatsim_id'] as String,
      (json['type'] as num).toInt(),
      (json['rating'] as num).toInt(),
      json['callsign'] as String,
      json['start'] as String,
      json['end'] as String,
      json['server'] as String,
    );

Map<String, dynamic> _$ConnectionDetailsToJson(ConnectionDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vatsim_id': instance.vatsim_id,
      'type': instance.type,
      'rating': instance.rating,
      'callsign': instance.callsign,
      'start': instance.start,
      'end': instance.end,
      'server': instance.server,
    };
