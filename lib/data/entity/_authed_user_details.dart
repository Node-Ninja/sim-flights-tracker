import 'package:json_annotation/json_annotation.dart';

part 'generated/_authed_user_details.g.dart';

@JsonSerializable()
class AuthedUserDetails {
  final String cid;
  final String fullName;
  final String firstName;
  final String lastName;
  final String? email;
  final String country;
  final String countryCode;
  final String controllerRating;
  final String pilotRating;
  final String division;

  AuthedUserDetails(
    this.cid,
    this.fullName,
    this.email,
    this.country,
    this.countryCode,
    this.controllerRating,
    this.pilotRating,
    this.division,
    this.firstName,
    this.lastName,
  );

  factory AuthedUserDetails.fromJson(Map<String, dynamic> json) => _$AuthedUserDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$AuthedUserDetailsToJson(this);
}