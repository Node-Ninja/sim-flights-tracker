import 'package:json_annotation/json_annotation.dart';

part 'generated/_vatsim_online_fir.g.dart';

@JsonSerializable()
class VatsimOnlineFir {
  final String icao;
  final String name;
  final String prefix;
  final String fir;
  final String freq;
  final String ctrName;
  final String ctrCallsign;

  VatsimOnlineFir(this.icao, this.name, this.prefix, this.fir, this.freq, this.ctrName, this.ctrCallsign);

  factory VatsimOnlineFir.fromJson(Map<String, dynamic> json) => _$VatsimOnlineFirFromJson(json);

  Map<String, dynamic> toJson() => _$VatsimOnlineFirToJson(this);
}
