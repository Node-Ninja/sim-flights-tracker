import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sim_flights_tracker/core/state/provider/providers.dart';
import 'package:sim_flights_tracker/core/theme/colors.dart';

import '../../core/config/i10n/generated/app_localizations.dart';
import '../../core/constants/patterns.dart';
import '../../core/debouncer.dart';
import '../../core/theme/spacing.dart';
import '../util/space_utils.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final bool isIOS = Platform.isIOS;
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black12,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Consumer(
                      builder: (context, reference, _) {

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
                          minMaxZoomPreference: const MinMaxZoomPreference(3, 22),
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
                            ...ref.watch(mapProvider).approachCircles,
                          },
                          cloudMapId: dotenv.get('GOOGLE_MAPS_CLOUD_KEY',),
                        );
                      }
                    ),
                  ),
                  Container(
                    margin: Spacing.halfMarginInset,
                    padding: const EdgeInsets.only(bottom: Spacing.quarterPadding),
                    decoration: BoxDecoration(
                      color: SftColors.primaryDark.withValues(alpha: 0.8),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: SftColors.lightGreen.withValues(alpha: 0.4), width: 1),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.searchWithFlightNumber,
                        prefixIcon: const Icon(LineIcons.search,),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(ValidationPatterns.alphaNumeric),
                      ],
                      onChanged: (value) {
                        _debouncer.run(() => ref.read(mapProvider.notifier).searchFlightsOnMap(value));
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: SftColors.lightGreen.withValues(alpha: 0.3),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/images/markers/del.png', width: 10,),
                      horizontalSpace(5),
                      Text(AppLocalizations.of(context)!.delivery, style: Theme.of(context).textTheme.bodySmall,),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset('assets/images/markers/gnd.png', width: 10,),
                      horizontalSpace(5),
                      Text(AppLocalizations.of(context)!.ground, style: Theme.of(context).textTheme.bodySmall,),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset('assets/images/markers/twr.png', width: 10,),
                      horizontalSpace(5),
                      Text(AppLocalizations.of(context)!.tower, style: Theme.of(context).textTheme.bodySmall,),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: SftColors.lightGreen.withValues(alpha: 0.3),
                          border: Border.all(color: SftColors.lightGreen, width: 2),
                          shape: BoxShape.circle,
                        ),
                      ),
                      horizontalSpace(5),
                      Text(AppLocalizations.of(context)!.approach, style: Theme.of(context).textTheme.bodySmall,),
                    ],
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