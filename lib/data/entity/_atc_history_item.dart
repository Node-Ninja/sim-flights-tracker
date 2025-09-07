
import 'package:json_annotation/json_annotation.dart';

part 'generated/_atc_history_item.g.dart';

@JsonSerializable()
class AtcHistoryItem {
  final ConnectionDetails connection;
  final int aircrafttracked;
  final int aircraftseen;
  final int flightsamended;
  final int handoffsinitiated;
  final int handoffsreceived;
  final int handoffsrefused;
  final int squawksassigned;
  final int cruisealtsmodified;
  final int tempaltsmodified;
  final int scratchpadmods;

  factory AtcHistoryItem.fromJson(Map<String, dynamic> json) => _$AtcHistoryItemFromJson(json);

  AtcHistoryItem(this.connection, this.aircrafttracked, this.aircraftseen, this.flightsamended, this.handoffsinitiated, this.handoffsreceived, this.handoffsrefused, this.squawksassigned, this.cruisealtsmodified, this.tempaltsmodified, this.scratchpadmods);

  Map<String, dynamic> toJson() => _$AtcHistoryItemToJson(this);
}

@JsonSerializable()
class ConnectionDetails {
  final int id;
  final String vatsim_id;
  final int type;
  final int rating;
  final String callsign;
  final String start;
  final String end;
  final String server;

  factory ConnectionDetails.fromJson(Map<String, dynamic> json) => _$ConnectionDetailsFromJson(json);

  ConnectionDetails(this.id, this.vatsim_id, this.type, this.rating, this.callsign, this.start, this.end, this.server);

  Map<String, dynamic> toJson() => _$ConnectionDetailsToJson(this);
}