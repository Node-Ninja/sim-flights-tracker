import 'package:json_annotation/json_annotation.dart';

part 'generated/_airport.g.dart';

@JsonSerializable()
class Airport {
  final String id;
  @JsonKey(name: 'ident')
  final String identification;
  final String type;
  final String name;
  final String municipality;
  final String continent;
  final String keywords;
  final Country country;
  final CountryRegion region;
  @JsonKey(name: 'latitude_deg')
  final String latitudeDeg;
  @JsonKey(name: 'longitude_deg')
  final String longitudeDeg;
  @JsonKey(name: 'elevation_ft')
  final String elevationFeet;
  @JsonKey(name: 'iso_country')
  final String isoCountry;
  @JsonKey(name: 'iso_region')
  final String isoRegion;
  @JsonKey(name: 'scheduled_service')
  final String scheduledService;
  @JsonKey(name: 'gps_code')
  final String gpsCode;
  @JsonKey(name: 'iata_code')
  final String iataCode;
  @JsonKey(name: 'local_code')
  final String localCode;
  @JsonKey(name: 'home_link')
  final String homeLink;
  @JsonKey(name: 'wikipedia_link')
  final String wikipediaLink;
  @JsonKey(name: 'freqs')
  final List<RadioFrequency>? radioFrequencies;
  final List<Runway>? runways;
  @JsonKey(name: 'navaids')
  final List<NavigationId>? navAids;

  Airport(this.id, this.identification, this.type, this.name, this.municipality, this.continent, this.keywords, this.country, this.region, this.latitudeDeg, this.longitudeDeg, this.elevationFeet, this.isoCountry, this.isoRegion, this.scheduledService, this.gpsCode, this.iataCode, this.localCode, this.homeLink, this.wikipediaLink, this.radioFrequencies, this.runways, this.navAids);

  factory Airport.fromJson(Map<String, dynamic> json) => _$AirportFromJson(json);

  Map<String, dynamic> toJson() => _$AirportToJson(this);
}

@JsonSerializable()
class RadioFrequency {
  final String id;
  final String type;
  final String description;
  @JsonKey(name: 'airport_ref')
  final String airportReference;
  @JsonKey(name: 'airport_ident')
  final String airportIdentification;
  @JsonKey(name: 'frequency_mhz')
  final String frequencyMegahertz;

  RadioFrequency(this.id, this.type, this.description, this.airportReference, this.airportIdentification, this.frequencyMegahertz);

  factory RadioFrequency.fromJson(Map<String, dynamic> json) => _$RadioFrequencyFromJson(json);

  Map<String, dynamic> toJson() => _$RadioFrequencyToJson(this);
}

@JsonSerializable()
class Country {
  final String id;
  final String code;
  final String name;
  final String continent;
  final String keywords;
  @JsonKey(name: 'wikipedia_link')
  final String wikipediaLink;

  Country(this.id, this.code, this.name, this.continent, this.keywords, this.wikipediaLink);

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);
}

@JsonSerializable()
class CountryRegion {
  final String id;
  final String code;
  final String name;
  final String continent;
  final String keywords;
  @JsonKey(name: 'iso_country')
  final String isoCountry;
  @JsonKey(name: 'local_code')
  final String localCode;
  @JsonKey(name: 'wikipedia_link')
  final String wikipediaLink;

  CountryRegion(this.id, this.code, this.name, this.continent, this.keywords, this.isoCountry, this.localCode, this.wikipediaLink);

  factory CountryRegion.fromJson(Map<String, dynamic> json) => _$CountryRegionFromJson(json);

  Map<String, dynamic> toJson() => _$CountryRegionToJson(this);
}

@JsonSerializable()
class Runway {
  final String id;
  final String surface;
  final String lighted;
  final String closed;
  @JsonKey(name: 'airport_ref')
  final String airportReference;
  @JsonKey(name: 'airport_ident')
  final String airportIdentification;
  @JsonKey(name: 'length_ft')
  final String lengthFeet;
  @JsonKey(name: 'width_ft')
  final String widthFeet;
  @JsonKey(name: 'le_ident')
  final String legIdent;
  @JsonKey(name: 'le_latitude_deg')
  final String legLatitudeDegrees;
  @JsonKey(name: 'le_longitude_deg')
  final String legLongitudeDegrees;
  @JsonKey(name: 'le_elevation_ft')
  final String legElevationFeet;
  @JsonKey(name: 'le_heading_degT')
  final String legHeadingDegrees;
  @JsonKey(name: 'le_displaced_threshold_ft')
  final String legDisplacedThresholdFeet;
  @JsonKey(name: 'he_ident')
  final String headIdent;
  @JsonKey(name: 'he_latitude_deg')
  final String headLatitudeDegrees;
  @JsonKey(name: 'he_longitude_deg')
  final String headLongitudeDegrees;
  @JsonKey(name: 'he_elevation_ft')
  final String headElevationFeet;
  @JsonKey(name: 'he_heading_degT')
  final String headHeadingDegrees;
  @JsonKey(name: 'he_displaced_threshold_ft')
  final String headDisplacedThresholdFeet;

  Runway(this.id, this.surface, this.lighted, this.closed, this.airportReference, this.airportIdentification, this.lengthFeet, this.widthFeet, this.legIdent, this.legLatitudeDegrees, this.legLongitudeDegrees, this.legElevationFeet, this.legHeadingDegrees, this.legDisplacedThresholdFeet, this.headIdent, this.headLatitudeDegrees, this.headLongitudeDegrees, this.headElevationFeet, this.headHeadingDegrees, this.headDisplacedThresholdFeet);

  factory Runway.fromJson(Map<String, dynamic> json) => _$RunwayFromJson(json);

  Map<String, dynamic> toJson() => _$RunwayToJson(this);
}

@JsonSerializable()
class NavigationId {
  final String id;
  final String filename;
  final String ident;
  final String name;
  final String type;
  @JsonKey(name: 'frequency_khz')
  final String frequencyKhz;
  @JsonKey(name: 'latitude_deg')
  final String latitudeDegrees;
  @JsonKey(name: 'longitude_deg')
  final String longitudeDegrees;
  @JsonKey(name: 'elevation_ft')
  final String elevationFeet;
  @JsonKey(name: 'iso_country')
  final String isoCountry;
  @JsonKey(name: 'dme_frequency_khz')
  final String dmeFrequencyKhz;
  @JsonKey(name: 'dme_channel')
  final String dmeChannel;
  @JsonKey(name: 'dme_latitude_deg')
  final String dmeLatitudeDegrees;
  @JsonKey(name: 'dme_longitude_deg')
  final String dmeLongitudeDegrees;
  @JsonKey(name: 'dme_elevation_ft')
  final String dmeElevationFeet;
  @JsonKey(name: 'slaved_variation_deg')
  final String slavedVariationDegrees;
  @JsonKey(name: 'magnetic_variation_deg')
  final String magneticVariationDegrees;
  final String usageType;
  final String power;
  @JsonKey(name: 'associated_airport')
  final String associatedAirport;

  NavigationId(this.id, this.filename, this.ident, this.name, this.type, this.frequencyKhz, this.latitudeDegrees, this.longitudeDegrees, this.elevationFeet, this.isoCountry, this.dmeFrequencyKhz, this.dmeChannel, this.dmeLatitudeDegrees, this.dmeLongitudeDegrees, this.dmeElevationFeet, this.slavedVariationDegrees, this.magneticVariationDegrees, this.usageType, this.power, this.associatedAirport);

  factory NavigationId.fromJson(Map<String, dynamic> json) => _$NavigationIdFromJson(json);

  Map<String, dynamic> toJson() => _$NavigationIdToJson(this);
}