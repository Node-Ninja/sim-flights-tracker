import 'package:json_annotation/json_annotation.dart';

part 'generated/vatsim_controller.g.dart';

@JsonSerializable()
class VatsimController {
  final int cid;
  final String name;
  final String callsign;
  final String frequency;
  final int facility;
  final int rating;
  final String server;
  @JsonKey(name: 'last_updated')
  final DateTime lastUpdated;
  @JsonKey(name: 'logon_time')
  final DateTime logonTime;
  @JsonKey(name: 'text_atis')
  final List<String>? textAtis;

  VatsimController(this.cid, this.name, this.callsign, this.frequency, this.facility, this.rating, this.server, this.lastUpdated, this.logonTime, this.textAtis);

  factory VatsimController.fromJson(Map<String, dynamic> json) => _$VatsimControllerFromJson(json);

  Map<String, dynamic> toJson() => _$VatsimControllerToJson(this);
}