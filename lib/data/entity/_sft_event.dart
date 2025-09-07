import 'package:json_annotation/json_annotation.dart';

part 'generated/_sft_event.g.dart';

@JsonSerializable()
class SftEvent {
  final num id;
  final String type;
  final String name;
  final String link;
  final List<EventOrganizer> organisers;
  final List<PartakingAirport> airports;
  final List<EventRoute> routes;
  @JsonKey(name: 'start_time')
  final String startTime;
  @JsonKey(name: 'end_time')
  final String endTime;
  @JsonKey(name: 'short_description')
  final String shortDescription;
  final String description;
  final String banner;

  SftEvent(
      this.id,
      this.type,
      this.name,
      this.link,
      this.organisers,
      this.airports,
      this.routes,
      this.startTime,
      this.endTime,
      this.shortDescription,
      this.description,
      this.banner);

  factory SftEvent.fromJson(Map<String, dynamic> json) => _$SftEventFromJson(json);

  Map<String, dynamic> toJson() => _$SftEventToJson(this);
}

@JsonSerializable()
class EventOrganizer {
  final String? region;
  final String? division;
  final String? subdivision;
  @JsonKey(name: 'organised_by_vatsim')
  final bool? organizedByVatsim;

  EventOrganizer(
      this.region, this.division, this.subdivision, this.organizedByVatsim);

  factory EventOrganizer.fromJson(Map<String, dynamic> json) => _$EventOrganizerFromJson(json);

  Map<String, dynamic> toJson() => _$EventOrganizerToJson(this);
}

@JsonSerializable()
class PartakingAirport {
  final String icao;

  PartakingAirport(this.icao);

  factory PartakingAirport.fromJson(Map<String, dynamic> json) => _$PartakingAirportFromJson(json);
  Map<String, dynamic> toJson() => _$PartakingAirportToJson(this);
}

@JsonSerializable()
class EventRoute {
  final String departure;
  final String arrival;
  final String route;

  EventRoute(this.departure, this.arrival, this.route);

  factory EventRoute.fromJson(Map<String, dynamic> json) => _$EventRouteFromJson(json);

  Map<String, dynamic> toJson() => _$EventRouteToJson(this);
}