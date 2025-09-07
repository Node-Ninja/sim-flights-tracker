import 'package:json_annotation/json_annotation.dart';

part 'generated/_vatsim_user_hours.g.dart';

@JsonSerializable()
class VatsimUserHours {
  final int id;
  final int pilot;
  final int atc;
  final int admin;
  final int sup;

  VatsimUserHours(
    this.id,
    this.pilot,
    this.atc,
    this.admin,
    this.sup,
  );

  factory VatsimUserHours.fromJson(Map<String, dynamic> json) => _$VatsimUserHoursFromJson(json);

  Map<String, dynamic> toJson() => _$VatsimUserHoursToJson(this);
}