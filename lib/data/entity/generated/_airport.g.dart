// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../_airport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Airport _$AirportFromJson(Map<String, dynamic> json) => Airport(
  json['id'] as String,
  json['ident'] as String,
  json['type'] as String,
  json['name'] as String,
  json['municipality'] as String,
  json['continent'] as String,
  json['keywords'] as String,
  Country.fromJson(json['country'] as Map<String, dynamic>),
  CountryRegion.fromJson(json['region'] as Map<String, dynamic>),
  json['latitude_deg'] as String,
  json['longitude_deg'] as String,
  json['elevation_ft'] as String,
  json['iso_country'] as String,
  json['iso_region'] as String,
  json['scheduled_service'] as String,
  json['gps_code'] as String,
  json['iata_code'] as String,
  json['local_code'] as String,
  json['home_link'] as String,
  json['wikipedia_link'] as String,
  (json['freqs'] as List<dynamic>?)
      ?.map((e) => RadioFrequency.fromJson(e as Map<String, dynamic>))
      .toList(),
  (json['runways'] as List<dynamic>?)
      ?.map((e) => Runway.fromJson(e as Map<String, dynamic>))
      .toList(),
  (json['navaids'] as List<dynamic>?)
      ?.map((e) => NavigationId.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AirportToJson(Airport instance) => <String, dynamic>{
  'id': instance.id,
  'ident': instance.identification,
  'type': instance.type,
  'name': instance.name,
  'municipality': instance.municipality,
  'continent': instance.continent,
  'keywords': instance.keywords,
  'country': instance.country.toJson(),
  'region': instance.region.toJson(),
  'latitude_deg': instance.latitudeDeg,
  'longitude_deg': instance.longitudeDeg,
  'elevation_ft': instance.elevationFeet,
  'iso_country': instance.isoCountry,
  'iso_region': instance.isoRegion,
  'scheduled_service': instance.scheduledService,
  'gps_code': instance.gpsCode,
  'iata_code': instance.iataCode,
  'local_code': instance.localCode,
  'home_link': instance.homeLink,
  'wikipedia_link': instance.wikipediaLink,
  if (instance.radioFrequencies?.map((e) => e.toJson()).toList()
      case final value?)
    'freqs': value,
  if (instance.runways?.map((e) => e.toJson()).toList() case final value?)
    'runways': value,
  if (instance.navAids?.map((e) => e.toJson()).toList() case final value?)
    'navaids': value,
};

RadioFrequency _$RadioFrequencyFromJson(Map<String, dynamic> json) =>
    RadioFrequency(
      json['id'] as String,
      json['type'] as String,
      json['description'] as String,
      json['airport_ref'] as String,
      json['airport_ident'] as String,
      json['frequency_mhz'] as String,
    );

Map<String, dynamic> _$RadioFrequencyToJson(RadioFrequency instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'description': instance.description,
      'airport_ref': instance.airportReference,
      'airport_ident': instance.airportIdentification,
      'frequency_mhz': instance.frequencyMegahertz,
    };

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
  json['id'] as String,
  json['code'] as String,
  json['name'] as String,
  json['continent'] as String,
  json['keywords'] as String,
  json['wikipedia_link'] as String,
);

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'name': instance.name,
  'continent': instance.continent,
  'keywords': instance.keywords,
  'wikipedia_link': instance.wikipediaLink,
};

CountryRegion _$CountryRegionFromJson(Map<String, dynamic> json) =>
    CountryRegion(
      json['id'] as String,
      json['code'] as String,
      json['name'] as String,
      json['continent'] as String,
      json['keywords'] as String,
      json['iso_country'] as String,
      json['local_code'] as String,
      json['wikipedia_link'] as String,
    );

Map<String, dynamic> _$CountryRegionToJson(CountryRegion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'continent': instance.continent,
      'keywords': instance.keywords,
      'iso_country': instance.isoCountry,
      'local_code': instance.localCode,
      'wikipedia_link': instance.wikipediaLink,
    };

Runway _$RunwayFromJson(Map<String, dynamic> json) => Runway(
  json['id'] as String,
  json['surface'] as String,
  json['lighted'] as String,
  json['closed'] as String,
  json['airport_ref'] as String,
  json['airport_ident'] as String,
  json['length_ft'] as String,
  json['width_ft'] as String,
  json['le_ident'] as String,
  json['le_latitude_deg'] as String,
  json['le_longitude_deg'] as String,
  json['le_elevation_ft'] as String,
  json['le_heading_degT'] as String,
  json['le_displaced_threshold_ft'] as String,
  json['he_ident'] as String,
  json['he_latitude_deg'] as String,
  json['he_longitude_deg'] as String,
  json['he_elevation_ft'] as String,
  json['he_heading_degT'] as String,
  json['he_displaced_threshold_ft'] as String,
);

Map<String, dynamic> _$RunwayToJson(Runway instance) => <String, dynamic>{
  'id': instance.id,
  'surface': instance.surface,
  'lighted': instance.lighted,
  'closed': instance.closed,
  'airport_ref': instance.airportReference,
  'airport_ident': instance.airportIdentification,
  'length_ft': instance.lengthFeet,
  'width_ft': instance.widthFeet,
  'le_ident': instance.legIdent,
  'le_latitude_deg': instance.legLatitudeDegrees,
  'le_longitude_deg': instance.legLongitudeDegrees,
  'le_elevation_ft': instance.legElevationFeet,
  'le_heading_degT': instance.legHeadingDegrees,
  'le_displaced_threshold_ft': instance.legDisplacedThresholdFeet,
  'he_ident': instance.headIdent,
  'he_latitude_deg': instance.headLatitudeDegrees,
  'he_longitude_deg': instance.headLongitudeDegrees,
  'he_elevation_ft': instance.headElevationFeet,
  'he_heading_degT': instance.headHeadingDegrees,
  'he_displaced_threshold_ft': instance.headDisplacedThresholdFeet,
};

NavigationId _$NavigationIdFromJson(Map<String, dynamic> json) => NavigationId(
  json['id'] as String,
  json['filename'] as String,
  json['ident'] as String,
  json['name'] as String,
  json['type'] as String,
  json['frequency_khz'] as String,
  json['latitude_deg'] as String,
  json['longitude_deg'] as String,
  json['elevation_ft'] as String,
  json['iso_country'] as String,
  json['dme_frequency_khz'] as String,
  json['dme_channel'] as String,
  json['dme_latitude_deg'] as String,
  json['dme_longitude_deg'] as String,
  json['dme_elevation_ft'] as String,
  json['slaved_variation_deg'] as String,
  json['magnetic_variation_deg'] as String,
  json['usageType'] as String,
  json['power'] as String,
  json['associated_airport'] as String,
);

Map<String, dynamic> _$NavigationIdToJson(NavigationId instance) =>
    <String, dynamic>{
      'id': instance.id,
      'filename': instance.filename,
      'ident': instance.ident,
      'name': instance.name,
      'type': instance.type,
      'frequency_khz': instance.frequencyKhz,
      'latitude_deg': instance.latitudeDegrees,
      'longitude_deg': instance.longitudeDegrees,
      'elevation_ft': instance.elevationFeet,
      'iso_country': instance.isoCountry,
      'dme_frequency_khz': instance.dmeFrequencyKhz,
      'dme_channel': instance.dmeChannel,
      'dme_latitude_deg': instance.dmeLatitudeDegrees,
      'dme_longitude_deg': instance.dmeLongitudeDegrees,
      'dme_elevation_ft': instance.dmeElevationFeet,
      'slaved_variation_deg': instance.slavedVariationDegrees,
      'magnetic_variation_deg': instance.magneticVariationDegrees,
      'usageType': instance.usageType,
      'power': instance.power,
      'associated_airport': instance.associatedAirport,
    };
