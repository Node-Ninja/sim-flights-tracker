// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../_vatsim_transceiver.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VatsimTransceiver _$VatsimTransceiverFromJson(Map<String, dynamic> json) =>
    VatsimTransceiver(
      json['callsign'] as String,
      (json['transceivers'] as List<dynamic>)
          .map((e) => Transceiver.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VatsimTransceiverToJson(VatsimTransceiver instance) =>
    <String, dynamic>{
      'callsign': instance.callsign,
      'transceivers': instance.transceivers.map((e) => e.toJson()).toList(),
    };

Transceiver _$TransceiverFromJson(Map<String, dynamic> json) => Transceiver(
  (json['id'] as num).toInt(),
  (json['frequency'] as num).toInt(),
  (json['latDeg'] as num).toDouble(),
  (json['lonDeg'] as num).toDouble(),
  (json['heightMslM'] as num).toDouble(),
  (json['heightAglM'] as num).toDouble(),
);

Map<String, dynamic> _$TransceiverToJson(Transceiver instance) =>
    <String, dynamic>{
      'id': instance.id,
      'frequency': instance.frequency,
      'latDeg': instance.latDeg,
      'lonDeg': instance.lonDeg,
      'heightMslM': instance.heightMslM,
      'heightAglM': instance.heightAglM,
    };
