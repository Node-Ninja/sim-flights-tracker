import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

@immutable
class MapState {
  final GoogleMapController? mapController;
  final Set<Marker> flightMarkers;
  final Set<Marker> visibleMarkers;
  final Set<Polyline> selectedFlightPath;
  final Set<Polygon> firPolygons;
  final Set<Marker> firLabelMarkers;
  final Set<Circle> approachCircles;
  final Set<Marker> approachLabels;
  final Set<Marker> groundStationMarkers;

  const MapState({
    this.mapController,
    this.flightMarkers = const {},
    this.visibleMarkers = const {},
    this.selectedFlightPath = const {},
    this.firPolygons = const {},
    this.firLabelMarkers = const {},
    this.approachCircles = const {},
    this.groundStationMarkers = const {},
    this.approachLabels = const {},
  });

  MapState copyWith({
    GoogleMapController? mapController,
    Set<Marker>? flightMarkers,
    Set<Marker>? visibleMarkers,
    Set<Polyline>? selectedFlightPath,
    Set<Polygon>? firPolygons,
    Set<Marker>? firLabelMarkers,
    Set<Circle>? approachCircles,
    Set<Marker>? groundStationMarkers,
    Set<Marker>? approachLabels,
  }) {
    return MapState(
      mapController: mapController ?? this.mapController,
      flightMarkers: flightMarkers ?? this.flightMarkers,
      visibleMarkers: visibleMarkers ?? this.visibleMarkers,
      selectedFlightPath: selectedFlightPath ?? this.selectedFlightPath,
      firPolygons: firPolygons ?? this.firPolygons,
      firLabelMarkers: firLabelMarkers ?? this.firLabelMarkers,
      approachCircles: approachCircles ?? this.approachCircles,
      groundStationMarkers: groundStationMarkers ?? this.groundStationMarkers,
      approachLabels: approachLabels ?? this.approachLabels,
    );
  }
}