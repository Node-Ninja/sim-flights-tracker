// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../_flight_plan_history_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlightPlanHistoryItem _$FlightPlanHistoryItemFromJson(
  Map<String, dynamic> json,
) => FlightPlanHistoryItem(
  (json['id'] as num).toInt(),
  (json['connectionId'] as num).toInt(),
  json['callSign'] as String,
  json['aircraft'] as String,
  json['cruiseSpeed'] as String,
  json['altitude'] as String,
  json['route'] as String,
  json['filed'] as String,
  json['vatsimId'] as String,
  json['flightType'] as String,
  json['departure'] as String,
  json['arrival'] as String,
  json['alternate'] as String,
  json['remarks'] as String,
  json['departureTime'] as String,
  (json['hoursEnRoute'] as num).toInt(),
  (json['minutesEnRoute'] as num).toInt(),
  (json['hoursFuel'] as num).toInt(),
  (json['minutesFuel'] as num).toInt(),
  json['assignedSquawk'] as String,
);

Map<String, dynamic> _$FlightPlanHistoryItemToJson(
  FlightPlanHistoryItem instance,
) => <String, dynamic>{
  'id': instance.id,
  'connectionId': instance.connectionId,
  'callSign': instance.callSign,
  'aircraft': instance.aircraft,
  'cruiseSpeed': instance.cruiseSpeed,
  'altitude': instance.altitude,
  'route': instance.route,
  'filed': instance.filed,
  'vatsimId': instance.vatsimId,
  'flightType': instance.flightType,
  'departure': instance.departure,
  'arrival': instance.arrival,
  'alternate': instance.alternate,
  'remarks': instance.remarks,
  'departureTime': instance.departureTime,
  'hoursEnRoute': instance.hoursEnRoute,
  'minutesEnRoute': instance.minutesEnRoute,
  'hoursFuel': instance.hoursFuel,
  'minutesFuel': instance.minutesFuel,
  'assignedSquawk': instance.assignedSquawk,
};
