import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sim_flights_tracker/presentation/widget/loader.dart';

import '../../core/state/provider/providers.dart';

class TabletScreen extends ConsumerStatefulWidget {
  const TabletScreen({super.key});

  @override
  ConsumerState<TabletScreen> createState() => _TabletScreenState();
}

class _TabletScreenState extends ConsumerState<TabletScreen> {
  final bool isIOS = Platform.isIOS;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black12,
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Consumer(
                          builder: (context, reference, _) {
                            var vatsimFlights = ref.watch(liveDataProvider.select((state) => state.vatsimFlights));

                            if (vatsimFlights.isNotEmpty) {
                              return GoogleMap(
                                onMapCreated: (controller) => ref.read(mapProvider.notifier).onMapCreatedHandler(controller),
                                onCameraIdle: () => ref.read(mapProvider.notifier).onCameraIdleHandler(),
                                initialCameraPosition: const CameraPosition(target: LatLng(0, 0)),
                                trafficEnabled: false,
                                mapToolbarEnabled: false,
                                zoomControlsEnabled: false,
                                myLocationButtonEnabled: false,
                                rotateGesturesEnabled: false,
                                buildingsEnabled: false,
                                minMaxZoomPreference: const MinMaxZoomPreference(3.5, 22),
                                markers: {
                                  ...reference.watch(mapProvider).visibleMarkers,
                                  ...reference.watch(mapProvider).firLabelMarkers,
                                  ...reference.watch(mapProvider).groundStationMarkers,
                                  ...reference.watch(mapProvider).approachLabels,
                                },
                                polylines: reference.watch(mapProvider).selectedFlightPath,
                                polygons: {
                                  ...reference.watch(mapProvider).firPolygons,
                                },
                                circles: {
                                  ...ref.read(mapProvider).approachCircles,
                                },
                                cloudMapId: '98e8a735cf72a1be',
                              );
                            } else {
                              return Center(child: SftLoader(),);
                            }
                          }
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}