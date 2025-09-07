import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart';
import 'package:sim_flights_tracker/core/constants/sim_network.dart';
import 'package:sim_flights_tracker/core/extensions/string_extensions.dart';
import 'package:sim_flights_tracker/core/state/model/map_state.dart';
import 'package:sim_flights_tracker/core/state/provider/providers.dart';
import 'package:sim_flights_tracker/data/entity/_controller_summary.dart';
import 'package:sim_flights_tracker/data/entity/_flight_summary.dart';

import '../../../data/entity/_air_traffic_control_sector.dart';
import '../../../domain/usecase/flights/get_flight_track.dart';
import '../../../presentation/util/bottom_sheets.dart';
import '../../constants/controller_type.dart';
import '../../dependency_injection/injection_container.dart';
import '../../theme/colors.dart';
import '../../utils.dart';

class MapStateNotifier extends Notifier<MapState> {
  @override
  MapState build() => MapState();

  Future<void> onMapCreatedHandler(GoogleMapController mapController) async {
    // Load the image from assets
    refreshMapItems(mapController);
  }

  Future<void> onCameraIdleHandler() async {
    var visibleFlightMarkers = await _getVisibleFlightMarkers();

    state = state.copyWith(visibleMarkers: visibleFlightMarkers);
  }

  Future<void> searchFlightsOnMap(String query) async {
    if (query.length > 3) {
      var mapController = state.mapController;
      var flightMarkers = state.flightMarkers;
      var cleanQuery = query.trim().toUpperCase();

      var matchingFlightMarker = flightMarkers.firstWhereOrNull((marker) => marker.markerId.value.toUpperCase() == cleanQuery);

      if (matchingFlightMarker != null && mapController != null) {
        mapController.animateCamera(CameraUpdate.newLatLng(matchingFlightMarker.position));
        matchingFlightMarker.onTap!();
      }
    }
  }

  Future<Set<Marker>> _getVisibleFlightMarkers({GoogleMapController? controller, Set<Marker>? currentMarkers}) async {
    var mapController = controller ?? state.mapController;
    var flightMarkers = currentMarkers ?? state.flightMarkers;
    Set<Marker> visibleMarkers = {};

    if (mapController != null) {
      var bounds = await mapController.getVisibleRegion();

      visibleMarkers = flightMarkers.where((marker) => bounds.contains(marker.position)).toSet();
    }

    return visibleMarkers;
  }

  Future<(Set<Marker>, Set<Polygon>)> _loadIfrItems(List<ControllerSummary> controllers, List<AirTrafficControlSector> atcSectors, SimNetwork simNetwork) async {

    Set<Marker> firLabelMarkers = {};
    Set<Polygon> firPolygons = {};

    var firControllers = controllers.where((controller) =>
        controller.callsign.contains(ControllerType.center.code) ||
        controller.callsign.contains(ControllerType.service.code)
    );

    for (var fir in firControllers) {
      var firIcao = fir.callsign.takeFirst(4);
      var callsign = fir.callsign
          .replaceAll(ControllerType.center.code, '')
          .replaceAll(ControllerType.service.code, '');

      callsign = callsign.replaceAll(RegExp(r'_\d+'), '');

      var boundaryName = callsign.replaceAll('_', '-');

      AirTrafficControlSector? sector = atcSectors.firstWhereOrNull((element) => element.callsign == callsign || element.boundary == boundaryName);

      if (sector != null) {
        await firLabelMarkers.addLabelMarker(LabelMarker(
          markerId: MarkerId('$firIcao ${fir.frequency}'),
          position: convertEPSG3857To4326(sector.lat, sector.lon),
          label: '${sector.name} Control',
          zIndex: 1200,
          backgroundColor: Colors.transparent,
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
          anchor: const Offset(0.5, 0.5,),
          onTap: () => showAreaControllerDetailsBottomSheet(fir, simNetwork, sector: sector),
        ));

        firPolygons.add(Polygon(
          polygonId: PolygonId('$firIcao${fir.frequency}'),
          strokeColor: Colors.blueAccent.withValues(alpha: 0.5),
          fillColor: Colors.blueAccent.withValues(alpha: 0.1),
          strokeWidth: 1,
          consumeTapEvents: true,
          points: [
            for (var i = 0; i < sector.feature.geometry.coordinates[0][0].length; i ++)
              convertEPSG3857To4326(sector.feature.geometry.coordinates[0][0][i][1], sector.feature.geometry.coordinates[0][0][i][0]),
          ],
          onTap: () => showAreaControllerDetailsBottomSheet(fir, simNetwork, sector: sector),
        ));
      }
    }

    return (
      firLabelMarkers,
      firPolygons
    );
  }

  Future<({Set<Circle> approachCircles, Set<Marker> approachLabels, Set<Marker> groundStationMarkers})> _loadGroundStationItems(SimNetwork simNetwork, List<ControllerSummary> controllers) async {
    Set<Marker> groundStationMarkers = {};
    Set<Circle> approachCircles = {};
    Set<Marker> approachLabels = {};
    
    var approachKeys = [];
    var airportsData = ref.read(appConfigProvider).airports;

    if (simNetwork == SimNetwork.vatsim) {
      var transceivers = ref.read(liveDataProvider).vatsimTransceivers;

      for (var transceiver in transceivers) {
        var current = transceiver.transceivers;
        var matchingController = controllers.firstWhereOrNull((c) => c.callsign == transceiver.callsign);

        if (current.isNotEmpty) {
          //  calculate coordinates based on station coordinates;
          var stationCoordinates = current.map((e) => LatLng(e.latDeg, e.lonDeg)).toList();

          //  get transceiver callsign last 4 chars to determine what type of controller this transceiver is for
          var type = transceiver.callsign.takeLast(3);
          var markerIconBytes = switch (type) {
            'DEL' => ref.read(appConfigProvider).deliveryMarkerImage,
            'GND' => ref.read(appConfigProvider).groundMarkerImage,
            'TWR' => ref.read(appConfigProvider).towerMarkerImage,
            _ => ref.read(appConfigProvider).deliveryMarkerImage
          };

          //  anchor value helps the ground station markers to be aligned next to each other at low zoom levels.
          var anchorValue = switch (type) {
            'DEL' => const Offset(2, 1.0),
            'GND' => const Offset(1.0, 1.0),
            'TWR' => const Offset(0.0, 1.0) ,
            _ => const Offset(2, 1.0)
          };

          if (stationCoordinates.isNotEmpty) {
            if (type == 'APP' || type == 'DEP') {
              var callSignParts = transceiver.callsign.split('_');
              var key = '${callSignParts[0]}_${callSignParts[callSignParts.length -1]}';

              if (!approachKeys.contains(key)) {
                approachCircles.add(Circle(
                    circleId: CircleId(key),
                    center: getCenterLatLong(stationCoordinates),
                    radius: 40000,
                    fillColor: SftColors.lightGreen.withValues(alpha: 0.3),
                    strokeColor: SftColors.lightGreen.withValues(alpha: 0.5),
                    strokeWidth: 2,
                    consumeTapEvents: true,
                    onTap: (matchingController != null)
                        ? () => showGeneralControllerBottomSheet(matchingController, simNetwork, airports: airportsData)
                        : null
                ));
                
                approachLabels.addLabelMarker(LabelMarker(
                  markerId: MarkerId(transceiver.callsign),
                  position: getCenterLatLong(stationCoordinates),
                  label: key,
                  zIndex: 1000,
                  backgroundColor: Colors.transparent,
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.grey
                  ),
                  anchor: const Offset(0.5, 0.5,),
                ));

                approachKeys.add(key);
              }
            } else if(type == 'DEL' || type == 'GND' || type == 'TWR') {
              groundStationMarkers.add(Marker(
                markerId: MarkerId(transceiver.callsign),
                position: getCenterLatLong(stationCoordinates),
                zIndexInt: 1200,
                anchor: anchorValue,
                flat: true,
                icon: BitmapDescriptor.bytes(markerIconBytes!, width: 10),
                onTap: (matchingController != null)
                    ? () => showGeneralControllerBottomSheet(matchingController, simNetwork, airports: airportsData)
                    : null,
              ));
            }
          }
        }
      }
    }

    if (simNetwork == SimNetwork.ivao) {
      for (var controller in controllers) {
        var type = controller.callsign.substring(controller.callsign.length - 3);
        var markerIconBytes = switch (type) {
          'DEL' => ref.read(appConfigProvider).deliveryMarkerImage,
          'GND' => ref.read(appConfigProvider).groundMarkerImage,
          'TWR' => ref.read(appConfigProvider).towerMarkerImage,
          _ => ref.read(appConfigProvider).deliveryMarkerImage
        };

        var anchorValue = switch (type) {
          'DEL' => const Offset(2, 1.0),
          'GND' => const Offset(1.0, 1.0),
          'TWR' => const Offset(0.0, 1.0) ,
          _ => const Offset(2, 1.0)
        };

        if (type == 'APP' || type == 'DEP') {
          var callSignParts = controller.callsign.split('_');
          var key = '${callSignParts[0]}_${callSignParts[callSignParts.length -1]}';

          if (!approachKeys.contains(key)) {
            approachCircles.add(Circle(
              circleId: CircleId(key),
              consumeTapEvents: true,
              center: LatLng(controller.latitude ?? 0, controller.longitude ?? 0),
              radius: 40000,
              fillColor: SftColors.lightGreen.withValues(alpha: 0.3),
              strokeColor: SftColors.lightGreen.withValues(alpha: 0.5),
              strokeWidth: 1,
              onTap: () => showGeneralControllerBottomSheet(controller, simNetwork, airports: airportsData),
            ));

            approachLabels.addLabelMarker(LabelMarker(
              markerId: MarkerId(key),
              position: LatLng(controller.latitude ?? 0, controller.longitude ?? 0),
              label: key,
              zIndex: 1000,
              backgroundColor: Colors.transparent,
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.grey
              ),
              anchor: const Offset(0.5, 0.5,),
            ));

            approachKeys.add(key);
          }
        } else {
          groundStationMarkers.add(Marker(
            markerId: MarkerId(controller.callsign),
            position: LatLng(controller.latitude ?? 0, controller.longitude ?? 0),
            zIndexInt: 1200,
            anchor: anchorValue,
            flat: true,
            icon: BitmapDescriptor.bytes(markerIconBytes!, width: 10),
            onTap: () => showGeneralControllerBottomSheet(controller, simNetwork, airports: airportsData),
          ));
        }
      }
    }

    return (
      groundStationMarkers: groundStationMarkers,
      approachCircles: approachCircles,
      approachLabels: approachLabels
    );
  }

  Future<void> renderFlightPath(SimNetwork simNetwork, FlightSummary flight) async {

    var flightTrack = await locator<GetFlightTrackUseCase>().call(FlightTrackParams(callsign: flight.callsign, network: simNetwork));
    Set<Polyline> trackPath = {};

    List<LatLng> points = [];

    flightTrack?.points.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    for (var track in flightTrack?.points ?? []) {
      points.add(LatLng(track.latitude, track.longitude));
    }

    if (points.isNotEmpty) {
      trackPath = {Polyline(
          jointType: JointType.round,
          polylineId: const PolylineId('flightPath'),
          width: 2,
          color: Colors.red,
          endCap: Cap.squareCap,
          geodesic: true,
          zIndex: 1200,
          points: points
      )};
    }

    state = state.copyWith(selectedFlightPath: trackPath);
  }

  Future<void> refreshMapItems([GoogleMapController? mapController]) async {
    var imageData = ref.read(appConfigProvider).planeMarkerImage;
    var simNetwork = ref.read(appConfigProvider).currentSimNetwork;
    var flights = simNetwork == SimNetwork.vatsim
        ? ref.read(liveDataProvider).vatsimFlights
        : ref.read(liveDataProvider).ivaoFlights;

    var vatsimControllers = ref.read(liveDataProvider).vatsimControllers;
    var ivaoControllers = ref.read(liveDataProvider).ivaoControllers;
    var airTrafficControlSectors = ref.read(appConfigProvider).airTrafficControlSectors;

    var flightMarkers = await buildFlightMarkers(flights, ref.read(appConfigProvider).airports, imageData!, simNetwork);
    var visibleMarkers = switch (mapController) {
      null => flightMarkers,
      _ => await _getVisibleFlightMarkers(controller: mapController, currentMarkers: flightMarkers),
    };

    var (firLabelMarkers, firPolygons) = switch (simNetwork) {
      SimNetwork.vatsim => await _loadIfrItems(vatsimControllers, airTrafficControlSectors, simNetwork),
      SimNetwork.ivao => await _loadIfrItems(ivaoControllers, airTrafficControlSectors, simNetwork),
    };

    var (:groundStationMarkers, :approachCircles, :approachLabels) = await _loadGroundStationItems(simNetwork,
        switch (simNetwork) {
          SimNetwork.vatsim => vatsimControllers,
          SimNetwork.ivao => ivaoControllers,
        }
    );

    state = state.copyWith(
      mapController: mapController,
      flightMarkers: flightMarkers,
      visibleMarkers: visibleMarkers,
      firLabelMarkers: firLabelMarkers,
      firPolygons: firPolygons,
      groundStationMarkers: groundStationMarkers,
      approachCircles: approachCircles,
      approachLabels: approachLabels,
    );
  }
}