// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../_authed_user_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthedUserDetails _$AuthedUserDetailsFromJson(Map<String, dynamic> json) =>
    AuthedUserDetails(
      json['cid'] as String,
      json['fullName'] as String,
      json['email'] as String?,
      json['country'] as String,
      json['countryCode'] as String,
      json['controllerRating'] as String,
      json['pilotRating'] as String,
      json['division'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
    );

Map<String, dynamic> _$AuthedUserDetailsToJson(AuthedUserDetails instance) =>
    <String, dynamic>{
      'cid': instance.cid,
      'fullName': instance.fullName,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      if (instance.email case final value?) 'email': value,
      'country': instance.country,
      'countryCode': instance.countryCode,
      'controllerRating': instance.controllerRating,
      'pilotRating': instance.pilotRating,
      'division': instance.division,
    };
