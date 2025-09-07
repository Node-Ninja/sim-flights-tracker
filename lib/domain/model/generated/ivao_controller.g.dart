// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../ivao_controller.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IvaoController _$IvaoControllerFromJson(Map<String, dynamic> json) =>
    IvaoController(
      (json['id'] as num).toInt(),
      (json['userId'] as num).toInt(),
      json['callsign'] as String,
      json['connectionType'] as String,
      json['atcSession'] == null
          ? null
          : IvaoAtcSession.fromJson(json['atcSession'] as Map<String, dynamic>),
      json['atcPosition'] == null
          ? null
          : IvaoAtcPosition.fromJson(
            json['atcPosition'] as Map<String, dynamic>,
          ),
    );

Map<String, dynamic> _$IvaoControllerToJson(
  IvaoController instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'callsign': instance.callsign,
  'connectionType': instance.connectionType,
  if (instance.atcSession?.toJson() case final value?) 'atcSession': value,
  if (instance.atcPosition?.toJson() case final value?) 'atcPosition': value,
};

IvaoAtcSession _$IvaoAtcSessionFromJson(Map<String, dynamic> json) =>
    IvaoAtcSession(
      json['position'] as String,
      (json['frequency'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$IvaoAtcSessionToJson(IvaoAtcSession instance) =>
    <String, dynamic>{
      'position': instance.position,
      if (instance.frequency case final value?) 'frequency': value,
    };

IvaoAtcPosition _$IvaoAtcPositionFromJson(Map<String, dynamic> json) =>
    IvaoAtcPosition(
      json['airportId'] as String,
      json['atcCallsign'] as String,
      json['isMilitary'],
      json['position'] as String,
      json['composePosition'] as String,
      (json['frequency'] as num?)?.toDouble(),
      (json['order'] as num?)?.toInt(),
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      DepartureArrival.fromJson(json['airport'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IvaoAtcPositionToJson(IvaoAtcPosition instance) =>
    <String, dynamic>{
      'airportId': instance.airportId,
      'atcCallsign': instance.atcCallsign,
      if (instance.isMilitary case final value?) 'isMilitary': value,
      'position': instance.position,
      'composePosition': instance.composePosition,
      if (instance.frequency case final value?) 'frequency': value,
      if (instance.order case final value?) 'order': value,
      if (instance.createdAt?.toIso8601String() case final value?)
        'createdAt': value,
      if (instance.updatedAt?.toIso8601String() case final value?)
        'updatedAt': value,
      'airport': instance.airport.toJson(),
    };
