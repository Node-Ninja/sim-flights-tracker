import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:sim_flights_tracker/core/config/router_config.dart';
import 'package:sim_flights_tracker/core/constants/sim_network.dart';
import 'package:sim_flights_tracker/core/constants/supported_language.dart';
import 'package:sim_flights_tracker/core/dependency_injection/injection_container.dart';
import 'package:sim_flights_tracker/core/extensions/string_extensions.dart';
import 'package:sim_flights_tracker/core/state/provider/providers.dart';
import 'package:sim_flights_tracker/data/entity/_air_traffic_control_sector.dart';
import 'package:sim_flights_tracker/data/entity/_atc_history_item.dart';
import 'package:sim_flights_tracker/data/entity/_controller_summary.dart';
import 'package:sim_flights_tracker/data/entity/_flight_plan_history_item.dart';
import 'package:sim_flights_tracker/data/entity/_flight_summary.dart';
import 'package:sim_flights_tracker/domain/model/airport_extract.dart';
import 'package:sim_flights_tracker/domain/usecase/controllers/get_controller_details.dart';
import 'package:sim_flights_tracker/presentation/util/space_utils.dart';

import '../../core/config/i10n/generated/app_localizations.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/spacing.dart';
import '../../core/utils.dart';
import '../../data/entity/_airport.dart';
import '../../data/entity/_sft_event.dart';
import '../../data/entity/_sft_event_summary.dart';
import '../widget/banner_add_container.dart';
import '../widget/custom_divider.dart';
import '../widget/flight_teaser.dart';
import '../widget/metar.dart';
import 'general_utils.dart';

void showAirportDetails(BuildContext context, Airport airport, WidgetRef ref, bool controllerDetailsEnabled) {
  var bannerAd = createBannerAd();
  var theme = Theme.of(context);
  var shouldShowPromos =false;
  var vatsimControllers = ref.read(liveDataProvider).vatsimControllers;
  var ivaoControllers = ref.read(liveDataProvider).ivaoControllers;
  var simNetwork = ref.read(appConfigProvider).currentSimNetwork;

  List<NavigationId> airportNavigationAids = airport.navAids ?? [];

  if (airport.navAids != null && airport.navAids!.isNotEmpty) {
    airportNavigationAids = airportNavigationAids.take(4).toList();
  }

  var airportControllers = switch (simNetwork) {
    SimNetwork.vatsim => vatsimControllers.where((cont) => cont.callsign.contains(airport.identification)).toList(),
    SimNetwork.ivao => ivaoControllers.where((cont) => cont.callsign.contains(airport.identification)).toList()
  };

  showModalBottomSheet(
      showDragHandle: false,
      scrollControlDisabledMaxHeightRatio: 100,
      elevation: 0,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      routeSettings: const RouteSettings(
          arguments: {
            'name': 'airportDetailsSheet'
          }
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          )
      ),
      builder: (context) => SafeArea(
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                customDivider(hasBottomMargin: false, hasTopMargin: false),
                customDivider(hasBottomMargin: false, hasTopMargin: false),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding:EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                airport.name.toUpperCase(),
                                style: const TextStyle(
                                  color: SftColors.lightOrange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            horizontalSpace(10,),
                            Row(
                              children: [
                                SizedBox(width: 1,height: 30, child: Container( color: SftColors.lightGreen.withValues(alpha: 0.2),),),
                                horizontalSpace(20),
                                GestureDetector(
                                  onTap: () => context.pop(),
                                  child: const Icon(LineIcons.times),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      customDivider(hasBottomMargin: false, hasTopMargin: false),
                      Container(
                        padding:EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget> [
                                Row(
                                  children: [
                                    Text(AppLocalizations.of(context)!.flag, style: const TextStyle(color: Colors.grey),),
                                  ],
                                ),
                                const SizedBox(height: 5,),
                                CachedNetworkImage(imageUrl: 'https://flagcdn.com/256x192/${airport.country.code.toLowerCase()}.png', width: 20),
                              ],
                            ),
                            horizontalSpace(15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget> [
                                Row(
                                  children: [
                                    Text(AppLocalizations.of(context)!.country, style: const TextStyle(color: Colors.grey),),
                                  ],
                                ),
                                const SizedBox(height: 5,),
                                Text(airport.country.name, style: const TextStyle(color: SftColors.customGrey), overflow: TextOverflow.ellipsis,)
                              ],
                            ),
                            horizontalSpace(15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget> [
                                Row(
                                  children: [
                                    Text(AppLocalizations.of(context)!.region, style: const TextStyle(color: Colors.grey), overflow: TextOverflow.ellipsis,),
                                  ],
                                ),
                                const SizedBox(height: 5,),
                                Text(airport.isoRegion, style: const TextStyle(color: SftColors.customGrey), overflow: TextOverflow.ellipsis,)
                              ],
                            ),
                            horizontalSpace(15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget> [
                                Text(AppLocalizations.of(context)!.elevation,
                                  overflow: TextOverflow.fade,
                                  style: const TextStyle(color: Colors.grey),),
                                const SizedBox(height: 5,),
                                Text('${airport.elevationFeet.isNotEmpty ? airport.elevationFeet : 0 } ft', style: const TextStyle(color: SftColors.customGrey),)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                customDivider(hasTopMargin: false, hasBottomMargin: false),
                Container(
                  decoration: const BoxDecoration(
                    color: SftColors.primaryDark,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column( // https://www.countryflags.io/za/flat/64.png
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget> [
                              const Row(
                                children: [
        
                                  Text('ICAO', style: TextStyle(color: Colors.grey),),
                                ],
                              ),
                              const SizedBox(height: 5,),
                              Text(airport.gpsCode, style: const TextStyle(color: SftColors.customGrey),)
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget> [
                              const Row(
                                children: [
        
                                  Text('IATA', style: TextStyle(color: Colors.grey),),
                                ],
                              ),
                              const SizedBox(height: 5,),
                              Text(airport.iataCode, style: const TextStyle(color: SftColors.customGrey),)
                            ],
                          ),
                          if (airport.navAids != null)
                            for (var navId in airportNavigationAids)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget> [
                                  Row(
                                    children: [
        
                                      Text((navId.type == 'VOR-DME') ? 'VOR' : navId.type, style: const TextStyle(color: Colors.grey),),
                                    ],
                                  ),
                                  const SizedBox(height: 5,),
                                  Text(navId.ident, style: const TextStyle(color: SftColors.customGrey),)
                                ],
                              ),
                        ],
                      ),
                    ],
                  ),
                ),
                customDivider(hasTopMargin: false, hasBottomMargin: false),
                if (airportControllers.isNotEmpty) Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10,),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 200
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Row(
                          children: [
                            const Icon(LineIcons.broadcastTower,),
                            horizontalSpace(3),
                            Text(AppLocalizations.of(context)!.onlineControllers, style: theme.textTheme.titleMedium,),
                          ],
                        ),
                        verticalSpace(10),
                        for (var controller in airportControllers.indexed)
                          GestureDetector(
                            onTap: () => (controllerDetailsEnabled) ? showGeneralControllerBottomSheet(controller.$2, simNetwork) : null,
                            child: Container(
                              decoration: BoxDecoration(
                                border: (controller.$1 != (airportControllers.length - 1)) ? Border(
                                  bottom: BorderSide(
                                    color: SftColors.lightGreen.withValues(alpha: 0.2),
                                    width: 1,
                                  ),
                                ): null,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 5,),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(controller.$2.callsign,),
                                  Text(controller.$2.facility, style: theme.textTheme.bodySmall),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(controller.$2.frequency, style: theme.textTheme.bodyMedium),
                                      if (controllerDetailsEnabled) Icon(Icons.chevron_right),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                if (airportControllers.isNotEmpty) customDivider(hasBottomMargin: false, hasTopMargin: false,),
                verticalSpace(10),
                Metar(icaoCode: airport.identification),
                verticalSpace(10),
                if (shouldShowPromos) customDivider(hasBottomMargin: false, hasTopMargin: false),
                if (shouldShowPromos) bannerAdContainer(bannerAd..load()),
              ],
            ),
          ),
        ),
      )
  );
}

void showLanguageSelectBottomSheet(BuildContext context, WidgetRef ref) {
  List<SupportedLanguage> languages = SupportedLanguage.values;
  var theme = Theme.of(context);

  showModalBottomSheet(
    showDragHandle: false,
    elevation: 0,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
    routeSettings: const RouteSettings(
        arguments: {
          'name': 'languageSelectSheet'
        }
    ),
    builder: (context) => SafeArea(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            customDivider(hasBottomMargin: false, hasTopMargin: false),
            customDivider(hasBottomMargin: false, hasTopMargin: false),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context)!.language, style: const TextStyle(
                          color: SftColors.lightOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),),],
                    ),
                  ),
                  horizontalSpace(20),
                  Row(
                    children: [
                      SizedBox(width: 1,height: 30, child: Container( color: SftColors.lightGreen.withValues(alpha: 0.2),),),
                      horizontalSpace(20),
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: const Icon(LineIcons.times),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            customDivider(hasTopMargin: false, hasBottomMargin: false),
            ListView.separated(
              shrinkWrap: true,
              itemCount: languages.length,
              padding: const EdgeInsets.all(20),
              separatorBuilder: (context, index) => customDivider(),
              itemBuilder: (context, index) => GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  ref.read(appConfigProvider.notifier).updateLocale(languages[index]);
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider('https://flagsapi.com/${languages[index].countryCode}/flat/24.png'),
                                  )
                              ),
                            ),
                            horizontalSpace(10),
                            Text(languages[index].language),
                          ],
                        ),
                      ),
                      if (languages[index] == ref.read(appConfigProvider).currentLanguage) Icon(LineIcons.check),
                    ],
                  ),
                ),
              ),
            ),
            customDivider(hasTopMargin: false, hasBottomMargin: false),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text('Please note that language support is still in BETA. To assist with translations, please contact me at appsupport@node-ninja.dev',
                style: theme.textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ),
    )
  );
}

void showAreaControllerDetailsBottomSheet(ControllerSummary controllerSummary, SimNetwork network, { List<AirTrafficControlSector> sectors = const [], AirTrafficControlSector? sector }) {
  var bannerAd = createBannerAd();

  var theme = Theme.of(AppRouter.shellNavigatorKey.currentContext!);

  var shouldShowPromos =false;

  var identityRecord = getCleanCallSignAndBoundaryName(controllerSummary.callsign);

  var callsign = identityRecord.$1;
  var boundaryName = identityRecord.$2;


  AirTrafficControlSector? currentSector = sector ?? sectors.firstWhereOrNull((element) => element.callsign == callsign || element.boundary == boundaryName);

  showModalBottomSheet(
    elevation: 0,
    backgroundColor: Colors.transparent,
    context: AppRouter.shellNavigatorKey.currentContext!,
    routeSettings: const RouteSettings(
        arguments: {
          'name': 'areaControllerDetailsSheet'
        }
    ),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero
    ),
    builder: (context) => FutureBuilder(
      future: locator<GetControllerDetailsUseCase>().call(ControllerDetailsParams(callsign: controllerSummary.callsign, network: network)),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var controllerDetails = snapshot.data;

          if (controllerDetails != null) {
            var timeOnlineMinutes = 0;

            if (controllerDetails.logonTime != null) {
              timeOnlineMinutes = DateTime.now().difference(controllerDetails.logonTime!).inMinutes;
            }

            var controllerAtis = controllerDetails.textAtis ?? [];

            return SafeArea(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customDivider(hasBottomMargin: false, hasTopMargin: false),
                    customDivider(hasBottomMargin: false, hasTopMargin: false),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(currentSector?.name ?? controllerDetails.callsign, style: const TextStyle(
                                  color: SftColors.lightOrange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),),
                                Text(controllerDetails.name, style: theme.textTheme.bodySmall,),
                                if (timeOnlineMinutes > 0) Text('Time online: ${minutesToStringDuration(timeOnlineMinutes)}', style: theme.textTheme.labelSmall,),
                              ],
                            ),
                          ),
                          horizontalSpace(20),
                          Row(
                            children: [
                              SizedBox(width: 1,height: 30, child: Container( color: SftColors.lightGreen.withValues(alpha: 0.2),),),
                              horizontalSpace(20),
                              GestureDetector(
                                onTap: () => context.pop(),
                                child: const Icon(LineIcons.times),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    customDivider(hasTopMargin: false, hasBottomMargin: false),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text('Position', style: theme.textTheme.labelSmall,),
                              Text(controllerSummary.facility.replaceAll('_', ' '), style: theme.textTheme.bodyLarge,),
                            ],
                          ),
                          if (currentSector != null)  Column(
                            children: [
                              Text('Division', style: theme.textTheme.labelSmall,),
                              Text(currentSector.division ?? 'Unknown', style: theme.textTheme.bodyLarge,),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Frequency', style: theme.textTheme.labelSmall,),
                              Text(controllerSummary.frequency, style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (controllerAtis.isNotEmpty) customDivider(hasTopMargin: false, hasBottomMargin: false),
                    if (controllerAtis.isNotEmpty) Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20,),
                      child: Text(controllerAtis.reduce((value, combined) => '$combined $value'), style: theme.textTheme.bodySmall,),
                    ),
                    if (shouldShowPromos) customDivider(hasBottomMargin: false, hasTopMargin: false),
                    if (shouldShowPromos) bannerAdContainer(bannerAd..load()),
                  ],
                ),
              ),
            );
          } else {
            return SafeArea(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(currentSector?.name ?? controllerSummary.callsign, style: theme.textTheme.titleMedium,),
                                Text(controllerSummary.frequency, style: theme.textTheme.bodySmall,),
                              ],
                            ),
                          ),
                          horizontalSpace(20),
                          Lottie.asset('assets/lottie/radar.json',
                              width: 50,
                              frameRate: FrameRate.max
                          ),
                        ],
                      ),
                    ),
                    if (shouldShowPromos) customDivider(hasBottomMargin: false, hasTopMargin: false),
                    if (shouldShowPromos)  bannerAdContainer(bannerAd..load()),
                  ],
                ),
              ),
            );
          }
        }

        if (snapshot.hasError) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(currentSector?.name ?? controllerSummary.callsign, style: theme.textTheme.titleMedium,),
                          Text(controllerSummary.frequency, style: theme.textTheme.bodySmall,),
                        ],
                      ),
                    ),
                    horizontalSpace(20),
                    Lottie.asset('assets/lottie/radar.json',
                        width: 50,
                        frameRate: FrameRate.max
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        return const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: SizedBox(
                  height: 10,
                  width: 10,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}

void showGeneralControllerBottomSheet(ControllerSummary controllerSummary, SimNetwork network, { List<AirportExtract> airports = const [] }) {
  var shouldShowPromos = false;

  var bannerAd = createBannerAd();

  //  find controller name or airport using provided callsign;
  var callsign = controllerSummary.callsign;
  var controllerIcao = callsign.takeFirst(4);

  //  find sector data
  var controllerAirport = airports.firstWhereOrNull((airport) => airport.identification == controllerIcao);

  var theme = Theme.of(AppRouter.shellNavigatorKey.currentContext!);

  showModalBottomSheet(
    elevation: 0,
    routeSettings: const RouteSettings(
      arguments: {
        'name': 'generalControllerDetailsSheet'
      }
    ),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero
    ),
    backgroundColor: Colors.transparent,
    context: AppRouter.shellNavigatorKey.currentContext!,
    builder: (context) => FutureBuilder(
      future: locator<GetControllerDetailsUseCase>().call(ControllerDetailsParams(callsign: controllerSummary.callsign, network: network)),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var controllerDetails = snapshot.data;

          if (controllerDetails != null) {
            var timeOnlineMinutes = 0;

            if (controllerDetails.logonTime != null) {
              timeOnlineMinutes = DateTime.now().difference(controllerDetails.logonTime!).inMinutes;
            }

            var controllerAtis = controllerDetails.textAtis ?? [];

            return SafeArea(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customDivider(hasBottomMargin: false, hasTopMargin: false),
                    customDivider(hasBottomMargin: false, hasTopMargin: false),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(controllerAirport?.name ?? controllerDetails.callsign, style: const TextStyle(
                                  color: SftColors.lightOrange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),),
                                if (controllerDetails.name.isNotEmpty) Text(controllerDetails.name, style: theme.textTheme.bodySmall,),
                                if (timeOnlineMinutes > 0) Text('Time online: ${minutesToStringDuration(timeOnlineMinutes)}', style: theme.textTheme.labelSmall,),
                              ],
                            ),
                          ),
                          horizontalSpace(20),
                          Row(
                            children: [
                              SizedBox(width: 1,height: 30, child: Container( color: SftColors.lightGreen.withValues(alpha: 0.2),),),
                              horizontalSpace(20),
                              GestureDetector(
                                onTap: () => context.pop(),
                                child: const Icon(LineIcons.times),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    customDivider(hasTopMargin: false, hasBottomMargin: false),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text('Position', style: theme.textTheme.labelSmall,),
                              Text(controllerSummary.facility, style: theme.textTheme.bodyLarge,),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Callsign', style: theme.textTheme.labelSmall,),
                              Text(controllerDetails.callsign, style: theme.textTheme.bodyLarge,),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Frequency', style: theme.textTheme.labelSmall,),
                              Text(controllerDetails.frequency, style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (controllerAtis.isNotEmpty) customDivider(hasTopMargin: false, hasBottomMargin: false),
                    if (controllerAtis.isNotEmpty) Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20,),
                      child: Text(controllerAtis.reduce((value, combined) => '$combined $value'), style: theme.textTheme.bodySmall,),
                    ),
                    if (shouldShowPromos) customDivider(hasBottomMargin: false, hasTopMargin: false),
                    if (shouldShowPromos) bannerAdContainer(bannerAd..load()),
                  ],
                ),
              ),
            );
          } else {
            return SafeArea(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(controllerSummary.callsign, style: theme.textTheme.titleMedium,),
                                Text(controllerSummary.frequency, style: theme.textTheme.bodySmall,),
                              ],
                            ),
                          ),
                          horizontalSpace(20),
                          Lottie.asset('assets/lottie/radar.json',
                              width: 50,
                              frameRate: FrameRate.max
                          ),
                        ],
                      ),
                    ),
                    if (shouldShowPromos) customDivider(hasBottomMargin: false, hasTopMargin: false),
                    if (shouldShowPromos) bannerAdContainer(bannerAd..load()),
                  ],
                ),
              ),
            );
          }
        }

        if (snapshot.hasError) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(controllerSummary.callsign, style: theme.textTheme.titleMedium,),
                          Text(controllerSummary.frequency, style: theme.textTheme.bodySmall,),
                        ],
                      ),
                    ),
                    horizontalSpace(20),
                    Lottie.asset('assets/lottie/radar.json',
                        width: 50,
                        frameRate: FrameRate.max
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        return const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: SizedBox(
                  height: 10,
                  width: 10,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}

void showAddEventReminderBottomSheet(BuildContext context, SftEvent event, WidgetRef ref) {
  var theme = Theme.of(context);
  var dateType = ref.read(appConfigProvider).dateType;
  var reminderOptions = [15,30,60,120];
  double screenWidth = MediaQuery.sizeOf(context).shortestSide > 599 ? 500 : MediaQuery.of(context).size.width;
  double reminderOptionWidth = ((screenWidth - 40) / reminderOptions.length);
  DateFormat dateTimeFormat = DateFormat('d MMMM HH:mm', Localizations.localeOf(context).toString());
  ref.read(notificationsProvider.notifier).updateMinutesBeforeReminder(15);


  var eventStartDateTime = DateTime.parse(event.startTime);
  var differenceMinutes =  eventStartDateTime.difference(DateTime.now()).inMinutes;

  showModalBottomSheet(
      elevation: 0,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      constraints: BoxConstraints(
        maxWidth: 500
      ),
      routeSettings: const RouteSettings(
          arguments: {
            'name': 'addEventReminderSheet'
          }
      ),
      builder: (context) => SafeArea(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customDivider(hasBottomMargin: false, hasTopMargin: false),
                customDivider(hasBottomMargin: false, hasTopMargin: false),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(event.name, style: const TextStyle(
                              color: SftColors.lightOrange,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),),
                            Text(convertDateTime(event.startTime, dateType, dateTimeFormat), style: theme.textTheme.bodySmall,),
                          ],
                        ),
                      ),
                      horizontalSpace(20),
                      Row(
                        children: [
                          SizedBox(width: 1,height: 30, child: Container( color: SftColors.lightGreen.withValues(alpha: 0.2),),),
                          horizontalSpace(20),
                          GestureDetector(
                            onTap: () => context.pop(),
                            child: const Icon(LineIcons.times),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                customDivider(),
                if (reminderOptions.isNotEmpty) Consumer(
                  builder: (_, reference, __) {
                    var currentSelectedMinutes = reference.watch(notificationsProvider).minutesBeforeReminder;
        
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            padding: const EdgeInsets.symmetric(horizontal: Spacing.standardPadding),
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Stack(
                              children: [
                                AnimatedPositioned(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                    width: reminderOptionWidth,
                                    height: 60,
                                    left: currentSelectedMinutes == 30
                                        ? reminderOptionWidth
                                        : currentSelectedMinutes == 60
                                            ? reminderOptionWidth * 2
                                            : currentSelectedMinutes == 120
                                              ? reminderOptionWidth * 3 : 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: const BorderRadius.all(Radius.circular(17)),
                                        border: Border.all(color: SftColors.lightGreen.withValues(alpha: 0.8), width: 2)
                                      ),
                                    )
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    for (var i = 0; i < reminderOptions.length; i++)
                                      GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {
                                          if (differenceMinutes >=  reminderOptions[i]) {
                                            reference.read(notificationsProvider.notifier).updateMinutesBeforeReminder(
                                                reminderOptions[i]
                                            );
                                          }
                                        },
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('${reminderOptions[i]}', style: theme.textTheme.titleMedium!.copyWith(
                                                color: (differenceMinutes >=  reminderOptions[i]) ? Colors.white : Colors.grey.withValues(alpha: 0.4)
                                            ),),
                                            Text(AppLocalizations.of(context)!.minutes, style: theme.textTheme.labelSmall!.copyWith(
                                                color: (differenceMinutes >=  reminderOptions[i]) ? SftColors.customGrey : Colors.grey.withValues(alpha: 0.4)
                                            ),),
                                          ],
                                        ),
                                      ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                ),
                customDivider(hasBottomMargin: false),
                Consumer(
                  builder: (_, reference, __) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                          child: const Row(
                            children: [
                              Icon(Icons.arrow_back_ios, color: SftColors.customGrey, size: 15,),
                              Text('Cancel', style: TextStyle(color: SftColors.customGrey),),
                            ],
                          ),
                          onPressed: () => context.pop(),
                        ),
                        TextButton(
                          onPressed: reminderOptions.contains(reference.read(notificationsProvider).minutesBeforeReminder) ? () {
                            reference.read(notificationsProvider.notifier).scheduleNotification(
                                event.name,
                                event.shortDescription,
                                DateTime.parse(event.startTime),
                                event,
                                event.id as int
                            );
        
                            context.pop();
                          } : null,
                          child: Row(
                            children: [
                              const Icon(LineIcons.bell, color: Colors.white),
                              Text(AppLocalizations.of(context)!.eventAdd),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
  );
}

void showCancelEventReminderBottomSheet(BuildContext context, SftEventSummary eventSummary, WidgetRef ref) {
  var theme = Theme.of(context);
  var dateType = ref.read(appConfigProvider).dateType;
  DateFormat dateTimeFormat = DateFormat('d MMMM HH:mm', Localizations.localeOf(context).toString());

  showModalBottomSheet(
      elevation: 0,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      routeSettings: const RouteSettings(
          arguments: {
            'name': 'cancelEventReminderSheet'
          }
      ),
      builder: (context) => SafeArea(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customDivider(hasBottomMargin: false, hasTopMargin: false),
                customDivider(hasBottomMargin: false, hasTopMargin: false),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(eventSummary.name, style: theme.textTheme.titleMedium,),
                          Text(convertDateTime(eventSummary.startTime, dateType, dateTimeFormat), style: theme.textTheme.bodySmall,),
                        ],
                      ),
                      horizontalSpace(20),
                      Row(
                        children: [
                          SizedBox(width: 1,height: 30, child: Container( color: SftColors.lightGreen.withValues(alpha: 0.2),),),
                          horizontalSpace(20),
                          GestureDetector(
                            onTap: () => context.pop(),
                            child: const Icon(LineIcons.times),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                customDivider(),
                Consumer(
                  builder: (_, reference, __) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        child: const Row(
                          children: [
                            Icon(Icons.arrow_back_ios, color: SftColors.customGrey, size: 15,),
                            Text('Cancel', style: TextStyle(color: SftColors.customGrey),),
                          ],
                        ),
                        onPressed: () => context.pop(),
                      ),
                      TextButton(
                        onPressed: () {
                          reference.read(notificationsProvider.notifier).deletePendingNotification(eventSummary.id);
                          context.pop();
                        },
                        child: Row(
                          children: [
                            const Icon(LineIcons.bellSlash, color: Colors.white),
                            Text(AppLocalizations.of(context)!.eventRemove),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]
            )
          ),
        ),
      )
  );
}

void showMapFlightSummaryBottomSheet(FlightSummary flight,SimNetwork simNetwork,AirportExtract? departureAirport,AirportExtract? arrivalAirport) {

  var context = AppRouter.shellNavigatorKey.currentContext!;
  var theme = Theme.of(context);
  PersistentBottomSheetController? sheetController;

  sheetController = showBottomSheet(
    context: context,
    backgroundColor: SftColors.primaryDark.withValues(alpha: 0.7),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero
    ),
    elevation: 0,
    builder: (ctx) => Consumer(
      builder: (ctx, ref, _) {

        ref.read(mapProvider.notifier).renderFlightPath(
          simNetwork,
          flight
        );

        return SafeArea(
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    customDivider(hasBottomMargin: false, hasTopMargin: false),
                    customDivider(hasBottomMargin: false, hasTopMargin: false),
                    FlightTeaser(flight: flight, simNetwork: simNetwork, showDetailsLabel: true, hasBorder: false, shouldPopBeforeNavigate: true, shouldShowCloseIcon: true, bottomSheetController: sheetController,),
                    customDivider(hasBottomMargin: false, hasTopMargin: false),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppLocalizations.of(context)!.altitude, style: theme.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),),
                              const SizedBox(height: 5,),
                              if (flight.altitude >= 10000)
                                Text('FL${(flight.altitude / 100).round()}', style: theme.textTheme.bodySmall,),
                              if (flight.altitude < 10000)
                                Text('ALT${flight.altitude.toString()}', style: theme.textTheme.bodySmall,),
                            ],
                          ),
                          SizedBox(width: 1,height: 20, child: Container( color: SftColors.lightGreen.withValues(alpha: 0.2),),),
                          Column(
                            children: [
                              Text(AppLocalizations.of(context)!.speed, style: theme.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),),
                              const SizedBox(height: 5,),
                              Text('${flight.groundspeed.toString()} KT', style: theme.textTheme.bodySmall,),
                            ],
                          ),
                          SizedBox(width: 1,height: 20, child: Container( color: SftColors.lightGreen.withValues(alpha: 0.2),),),
                          Column(
                            children: [
                              Text(AppLocalizations.of(context)!.heading, style: theme.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),),
                              const SizedBox(height: 5,),
                              Text(flight.heading.toString(), style: theme.textTheme.bodySmall,)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]
              ),
            ),
          ),
        );
      },
    )
  );
}

void showFlightPlanHistoryBottomSheet(FlightPlanHistoryItem flightPlan,SimNetwork simNetwork, BuildContext context) {
  var theme = Theme.of(context);

  showModalBottomSheet(
    elevation: 0,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
    routeSettings: const RouteSettings(
        arguments: {
          'name': 'viewFlightPlanHistorySheet'
        }
    ),
    builder: (ctx) {
      return SafeArea(
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  customDivider(hasBottomMargin: false, hasTopMargin: false),
                  customDivider(hasBottomMargin: false, hasTopMargin: false),
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding:EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    flightPlan.callSign,
                                    style: const TextStyle(
                                      color: SftColors.lightOrange,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text('${flightPlan.departure} - ${flightPlan.arrival}', style: theme.textTheme.bodySmall,),
                                ],
                              ),
                              horizontalSpace(10,),
                              SizedBox(width: 1,height: 30, child: Container( color: SftColors.lightGreen.withValues(alpha: 0.2),),),
                              horizontalSpace(10,),
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${flightPlan.flightType} - ${flightPlan.aircraft.takeFirst(10)}', style: theme.textTheme.titleSmall,),
                                      Text('${AppLocalizations.of(context)!.enRoute} : ${flightPlan.hoursEnRoute}${AppLocalizations.of(context)!.hourLetter}:${flightPlan.minutesEnRoute}${AppLocalizations.of(context)!.minuteShort}', style: theme.textTheme.bodySmall,),
                                    ],
                                  ),
                              ),
                              horizontalSpace(10,),
                              Row(
                                children: [
                                  SizedBox(width: 1,height: 30, child: Container( color: SftColors.lightGreen.withValues(alpha: 0.2),),),
                                  horizontalSpace(20),
                                  GestureDetector(
                                    onTap: () => context.pop(),
                                    child: const Icon(LineIcons.times),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        customDivider(hasBottomMargin: false, hasTopMargin: false),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(AppLocalizations.of(context)!.cruiseAltitude, style: theme.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold), overflow: TextOverflow.clip, textAlign: TextAlign.center,),
                                    const SizedBox(height: 5,),
                                    Text(flightPlan.altitude, style: theme.textTheme.bodySmall,),
                                  ],
                                ),
                              ),
                              horizontalSpace(10,),
                              SizedBox(width: 1,height: 20, child: Container( color: SftColors.lightGreen.withValues(alpha: 0.2),),),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text('Squawk', style: theme.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                                    const SizedBox(height: 5,),
                                    Text(flightPlan.assignedSquawk, style: theme.textTheme.bodySmall,),
                                  ],
                                ),
                              ),
                              SizedBox(width: 1,height: 20, child: Container( color: SftColors.lightGreen.withValues(alpha: 0.2),),),
                              horizontalSpace(10,),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(AppLocalizations.of(context)!.cruiseSpeed, style: theme.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),  overflow: TextOverflow.clip, textAlign: TextAlign.center,),
                                    const SizedBox(height: 5,),
                                    Text(flightPlan.cruiseSpeed, style: theme.textTheme.bodySmall,)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        customDivider(hasTopMargin: false, hasBottomMargin: false),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20,),
                          child: Text(flightPlan.route, style: theme.textTheme.bodySmall,),
                        ),
                        customDivider(hasTopMargin: false, hasBottomMargin: false),
                      ],
                    ),
                  ),
                ]
            ),
          ),
        ),
      );
    }
  );
}

void showControllerHistoryBottomSheet(BuildContext context, AtcHistoryItem controlData, String onlineHours, WidgetRef ref) {
  var theme = Theme.of(context);
  var startedDate = DateTime.parse(controlData.connection.start);
  var endDate = DateTime.parse(controlData.connection.end);
  var locale = ref.read(appConfigProvider.select((state) => state.currentLocale));

  DateFormat dateFormat = DateFormat('dd MMM yyyy HH:mm', locale.toString());

  showModalBottomSheet(
    elevation: 0,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
    routeSettings: const RouteSettings(
        arguments: {
          'name': 'viewControllerHistorySheet'
        }
    ),
    builder: (ctx) {
      return SafeArea(
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                customDivider(hasBottomMargin: false, hasTopMargin: false),
                customDivider(hasBottomMargin: false, hasTopMargin: false),
                Container(
                  width: double.infinity,
                  child: Container(
                    padding:EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controlData.connection.callsign,
                              style: const TextStyle(
                                color: SftColors.lightOrange,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(onlineHours, style: theme.textTheme.bodySmall,),
                          ],
                        ),
                        horizontalSpace(10,),
                        SizedBox(width: 1,height: 30, child: Container( color: SftColors.lightGreen.withValues(alpha: 0.2),),),
                        horizontalSpace(10,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${dateFormat.format(startedDate)}Z', style: theme.textTheme.bodySmall,),
                              Text('${dateFormat.format(endDate)}Z', style: theme.textTheme.bodySmall,),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(width: 1,height: 30, child: Container( color: SftColors.lightGreen.withValues(alpha: 0.2),),),
                            horizontalSpace(20),
                            GestureDetector(
                              onTap: () => context.pop(),
                              child: const Icon(LineIcons.times),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                customDivider(hasBottomMargin: false, hasTopMargin: false),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text('Aircraft Seen', style: theme.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold), overflow: TextOverflow.clip, textAlign: TextAlign.center,),
                            const SizedBox(height: 5,),
                            Text(controlData.aircraftseen.toString(), style: theme.textTheme.bodySmall,),
                          ],
                        ),
                      ),
                      horizontalSpace(10,),
                      SizedBox(width: 1,height: 20, child: Container( color: SftColors.lightGreen.withValues(alpha: 0.2),),),
                      Expanded(
                        child: Column(
                          children: [
                            Text('Aircraft Tracked', style: theme.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                            const SizedBox(height: 5,),
                            Text(controlData.aircrafttracked.toString(), style: theme.textTheme.bodySmall,),
                          ],
                        ),
                      ),
                      SizedBox(width: 1,height: 20, child: Container( color: SftColors.lightGreen.withValues(alpha: 0.2),),),
                      horizontalSpace(10,),
                      Expanded(
                        child: Column(
                          children: [
                            Text('Squawk Assigned', style: theme.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),  overflow: TextOverflow.clip, textAlign: TextAlign.center,),
                            const SizedBox(height: 5,),
                            Text(controlData.squawksassigned.toString(), style: theme.textTheme.bodySmall,)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]
            ),
          ),
        ),
      );
    }
  );
}