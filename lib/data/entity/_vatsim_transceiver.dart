
import 'package:json_annotation/json_annotation.dart';

part 'generated/_vatsim_transceiver.g.dart';

@JsonSerializable()
class VatsimTransceiver {
  final String callsign;
  final List<Transceiver> transceivers;

  VatsimTransceiver(this.callsign, this.transceivers);

  factory VatsimTransceiver.fromJson(Map<String, dynamic> json) => _$VatsimTransceiverFromJson(json);
  Map<String, dynamic> toJson() => _$VatsimTransceiverToJson(this);
}

@JsonSerializable()
class Transceiver {
  final int id;
  final int frequency;
  final double latDeg;
  final double lonDeg;
  final double heightMslM;
  final double heightAglM;

  Transceiver(this.id, this.frequency, this.latDeg, this.lonDeg, this.heightMslM, this.heightAglM);

  factory Transceiver.fromJson(Map<String, dynamic> json) => _$TransceiverFromJson(json);

  Map<String, dynamic> toJson() => _$TransceiverToJson(this);
}