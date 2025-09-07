import 'package:json_annotation/json_annotation.dart';
import 'ivao_flight.dart';

part 'generated/ivao_controller.g.dart';

@JsonSerializable()
class IvaoController {
  final int id;
  final int userId;
  final String callsign;
  final String connectionType;
  final IvaoAtcSession? atcSession;
  final IvaoAtcPosition? atcPosition;

  IvaoController(this.id, this.userId, this.callsign, this.connectionType, this.atcSession, this.atcPosition);

  factory IvaoController.fromJson(Map<String, dynamic> json) => _$IvaoControllerFromJson(json);

  Map<String, dynamic> toJson() => _$IvaoControllerToJson(this);
}

@JsonSerializable()
class IvaoAtcSession {
  final String position;
  final double? frequency;

  IvaoAtcSession(this.position, this.frequency);

  factory IvaoAtcSession.fromJson(Map<String, dynamic> json) => _$IvaoAtcSessionFromJson(json);

  Map<String, dynamic> toJson() => _$IvaoAtcSessionToJson(this);
}

@JsonSerializable()
class IvaoAtcPosition {
  final String airportId;
  final String atcCallsign;
  final dynamic isMilitary;
  final String position;
  final String composePosition;
  final double? frequency;
  final int? order;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DepartureArrival airport;

  IvaoAtcPosition(this.airportId, this.atcCallsign, this.isMilitary, this.position, this.composePosition, this.frequency, this.order, this.createdAt, this.updatedAt, this.airport);

  factory IvaoAtcPosition.fromJson(Map<String, dynamic> json) => _$IvaoAtcPositionFromJson(json);

  Map<String, dynamic> toJson() => _$IvaoAtcPositionToJson(this);
}