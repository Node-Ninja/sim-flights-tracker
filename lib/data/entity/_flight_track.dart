import 'package:json_annotation/json_annotation.dart';

part 'generated/_flight_track.g.dart';

@JsonSerializable()
class FlightTrack {
  final String callsign;
  final List<PointPosition> points;

  FlightTrack(this.callsign, this.points);

  factory FlightTrack.fromJson(Map<String, dynamic> json) => _$FlightTrackFromJson(json);

  Map<String, dynamic> toJson() => _$FlightTrackToJson(this);
}

@JsonSerializable()
class PointPosition {
  final double latitude;
  final double longitude;
  final int timestamp;

  PointPosition(this.latitude, this.longitude, this.timestamp);

  factory PointPosition.fromJson(Map<String, dynamic> json) => _$PointPositionFromJson(json);

  Map<String, dynamic> toJson() => _$PointPositionToJson(this);
}