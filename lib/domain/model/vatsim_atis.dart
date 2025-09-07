import 'package:json_annotation/json_annotation.dart';

part 'generated/vatsim_atis.g.dart';

@JsonSerializable()
class VatsimAtis {
  final int cid;
  final String name;
  final String callsign;
  final String frequency;
  final int facility;
  final int rating;
  final String server;
  @JsonKey(name: 'visual_range')
  final int visualRange;
  @JsonKey(name: 'atis_code')
  final String? atisCode;
  @JsonKey(name: 'last_updated')
  final String lastUpdated;
  @JsonKey(name: 'logon_time')
  final String logonTime;
  @JsonKey(name: 'text_atis')
  final List<String>? textAtis;

  VatsimAtis(this.cid, this.name, this.callsign, this.frequency, this.facility, this.rating, this.server, this.visualRange, this.atisCode, this.lastUpdated, this.logonTime, this.textAtis);

  factory VatsimAtis.fromJson(Map<String, dynamic> json) => _$VatsimAtisFromJson(json);

  Map<String, dynamic> toJson() => _$VatsimAtisToJson(this);
}