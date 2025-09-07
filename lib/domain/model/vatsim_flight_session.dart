import 'package:json_annotation/json_annotation.dart';

part 'generated/vatsim_flight_session.g.dart';

@JsonSerializable()
class VatsimFlightSession {
  final num id;
  @JsonKey(name: 'vatsim_id')
  final String vatsimId;
  final int type;
  final int rating;
  final String callsign;
  final String start;
  final String end;
  final String server;

  VatsimFlightSession(this.id, this.vatsimId, this.type, this.rating, this.callsign, this.start, this.end, this.server);

  factory VatsimFlightSession.fromJson(Map<String, dynamic> json) => _$VatsimFlightSessionFromJson(json);

  Map<String, dynamic> toJson() => _$VatsimFlightSessionToJson(this);
}



// {
// "id": 99331391,
// "vatsim_id": "1547018",
// "type": 1,
// "rating": 0,
// "callsign": "EIN274",
// "start": "2024-03-27T16:45:32Z",
// "end": "2024-03-27T18:20:11Z",
// "server": "GERMANY"
// }