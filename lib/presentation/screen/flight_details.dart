import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:sim_flights_tracker/core/constants/date_type.dart';
import 'package:sim_flights_tracker/core/constants/sim_network.dart';
import 'package:sim_flights_tracker/core/dependency_injection/injection_container.dart';
import 'package:sim_flights_tracker/core/exceptions/flight_not_found_e.dart';
import 'package:sim_flights_tracker/core/extensions/string_extensions.dart';
import 'package:sim_flights_tracker/core/state/provider/providers.dart';
import 'package:sim_flights_tracker/domain/usecase/aircraft/get_aircraft_details.dart';
import 'package:sim_flights_tracker/domain/usecase/airlines/get_airline.dart';
import 'package:sim_flights_tracker/domain/usecase/airports/get_airport.dart';
import 'package:sim_flights_tracker/domain/usecase/flights/get_flight_details.dart';
import 'package:sim_flights_tracker/presentation/util/general_utils.dart';

import '../../core/config/i10n/generated/app_localizations.dart';
import '../../core/theme/colors.dart';
import '../../data/entity/_aircraft.dart';
import '../../data/entity/_airline.dart';
import '../../data/entity/_airport.dart';
import '../../data/entity/_flight.dart';
import '../../data/entity/_flight_summary.dart';
import '../util/bottom_sheets.dart';
import '../util/flight_calculations.dart';
import '../util/space_utils.dart';
import '../widget/banner_add_container.dart';
import '../widget/custom_divider.dart';
import '../widget/loader.dart';
import '../widget/my_separator.dart';
import '../widget/sft_widgets.dart';
import 'error/generic_error_screen.dart';
import 'error/not_found_screen.dart';

class FlightDetails extends StatelessWidget {
  final String callsign;
  final FlightPlanSummary? flightPlan;

  FlightDetails({super.key, required this.callsign, required this.flightPlan});

  final _bannerAd = createBannerAd();

  @override
  Widget build(BuildContext context) {
    var shouldShowPromos = false;
    var showLogos = true;

    try {
      DateFormat dateFormat = DateFormat('dd MMMM, HH:mm', Localizations.localeOf(context).toString());

      var theme = Theme.of(context);

      return Scaffold(
        body: Consumer(
          builder: (_, ref, __) {
            var currentSimNetwork = ref.read(appConfigProvider).currentSimNetwork;
            var allFlights = ref.watch(liveDataProvider.select((state) => (state.vatsimFlights, state.ivaoFlights)));

            return FutureBuilder(
              future: Future.wait([
                locator<GetFlightDetailsUseCase>().call(FlightDetailsParams(callSign: callsign, network: currentSimNetwork)),
                locator<GetAirlineUseCase>().call(AirlineDetailsParams(icaoId: callsign.takeFirst(3))),
                if (flightPlan != null) locator<GetAirportUseCase>().call(AirportDetailsParams(icaoId: flightPlan!.departure.toUpperCase())),
                if (flightPlan != null) locator<GetAirportUseCase>().call(AirportDetailsParams(icaoId: flightPlan!.arrival.toUpperCase())),
              ]),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {

                if (snapshot.hasData) {

                  if (snapshot.data?[0] == null) {
                    //  flightData not found;
                    return NotFoundScreen(message: AppLocalizations.of(context)!.flightDisconnected,);
                  }

                  Flight flight = snapshot.data?[0];
                  Airline? airline = snapshot.data?[1];

                  //  all flight data available

                  Airport? departureAirport = (snapshot.data!.length >= 3) ? snapshot.data![2] : null;
                  Airport? arrivalAirport = (snapshot.data!.length >= 4) ? snapshot.data![3] : null;

                  int distanceTotal = 0;
                  int distanceTravelled = 0;
                  int distanceRemaining = 0;
                  double etaTemp = 0;
                  int eta = 0;
                  List<int> timeVal = [0,0,0];
                  String phase = AppLocalizations.of(context)!.clearance;

                  bool flyingWithoutOfp = flight.flightPlan?.departure == null && flight.flightPlan?.arrival == null && flight.groundSpeed > 20;

                  //  calculate distances if both airports data is available;
                  if (departureAirport != null && arrivalAirport != null) {

                    distanceTotal = calculateGeoDistance(
                      startLatitude: double.parse(departureAirport.latitudeDeg),
                      startLongitude: double.parse(departureAirport.longitudeDeg),
                      endLatitude: double.parse(arrivalAirport.latitudeDeg),
                      endLongitude: double.parse(arrivalAirport.longitudeDeg),
                    );

                    distanceTravelled = calculateGeoDistance(
                      startLatitude: double.parse(departureAirport.latitudeDeg),
                      startLongitude: double.parse(departureAirport.longitudeDeg),
                      endLatitude: flight.latitude,
                      endLongitude: flight.longitude,
                    );

                    distanceRemaining = calculateGeoDistance(
                      startLatitude: flight.latitude,
                      startLongitude: flight.longitude,
                      endLatitude: double.parse(arrivalAirport.latitudeDeg),
                      endLongitude: double.parse(arrivalAirport.longitudeDeg),
                    );

                    if (distanceTravelled < 1 && departureAirport.identification != arrivalAirport.identification) {
                      phase = AppLocalizations.of(context)!.boarding;
                    } else if (departureAirport.identification == arrivalAirport.identification) {
                      phase = AppLocalizations.of(context)!.circuits;
                    } else if (distanceTravelled >= 1 && distanceTravelled <= 20) {
                      phase = AppLocalizations.of(context)!.departing;
                    } else if (distanceTravelled > 20 && distanceRemaining > 30) {
                      phase = AppLocalizations.of(context)!.enRoute;
                    } else if (distanceRemaining <= 30 && distanceRemaining >= 1 &&  flight.groundSpeed > 100) {
                      phase = AppLocalizations.of(context)!.arrivingShortly;
                    } else if (distanceRemaining <= 1 && flight.groundSpeed < 160) {
                      phase = AppLocalizations.of(context)!.arrived;
                    } else {
                      phase = AppLocalizations.of(context)!.unknown;
                    }
                  }

                  if (distanceRemaining > 0 && flight.groundSpeed > 50) {
                    etaTemp = distanceRemaining / flight.groundSpeed;
                    etaTemp = etaTemp * 60 * 60;
                    eta = etaTemp.floor();
                    timeVal = timeValues(eta);
                  }

                  return Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              height: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: const AssetImage('assets/images/map.png'),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(Colors.black.withValues(alpha: 0.2), BlendMode.dstATop)
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: const SizedBox(
                                          width: 50,
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.chevron_left,
                                                color: Colors.white,
                                                size: 32,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            flight.callsign,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          if (airline != null && airline.iata.isNotEmpty) Text(
                                            '${airline.iata}${flight.callsign.substring(3)}',
                                            style: const TextStyle(
                                                color: Color(0xffB1B1B1),
                                                fontSize: 12
                                            ),
                                          ),
                                        ],
                                      ),
                                      labelPill(currentSimNetwork.upperName, theme.textTheme.labelMedium!, SftColors.lightGreen),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: () {
                                              if (departureAirport != null) {
                                                showAirportDetails(context, departureAirport, ref, true);
                                              }
                                            },
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Icon(
                                                  Symbols.flight_takeoff,
                                                  color: Colors.white,
                                                ),
                                                const SizedBox(height: 5,),
                                                Text(
                                                  (flight.flightPlan?.departure != null && flight.flightPlan?.departure != '')
                                                      ? flight.flightPlan!.departure!
                                                      : 'No OFP',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                const MySeparator(color: Colors.grey),
                                                AnimatedSize(
                                                  duration: const Duration(seconds: 1),
                                                  curve: Curves.ease,
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                                    decoration: BoxDecoration(
                                                      color: SftColors.lightOrange,
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: Text(
                                                      phase,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: () {
                                              if (arrivalAirport != null) {
                                                showAirportDetails(context, arrivalAirport, ref, true);
                                              }
                                            },
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                const Icon(
                                                  Symbols.flight_land,
                                                  color: Colors.white,
                                                ),
                                                const SizedBox(height: 5,),
                                                Text(
                                                  (flight.flightPlan?.arrival != null && flight.flightPlan?.arrival != '')
                                                      ? flight.flightPlan!.arrival!
                                                      : 'No OFP',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          if (departureAirport != null) Text(
                                            departureAirport.municipality,
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                            ),
                                          ),
                                          if (arrivalAirport != null)Text(
                                            arrivalAirport.municipality,
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(20,),
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                      color: SftColors.lightGreen.withValues(alpha: 0.2),
                                    )
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (currentSimNetwork == SimNetwork.vatsim) Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          AppLocalizations.of(context)!.captain(flight.pilotName),
                                          style: theme.textTheme.titleMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (currentSimNetwork == SimNetwork.vatsim)  verticalSpace(20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.aircraft,
                                        style: const TextStyle(color: Colors.grey),
                                      ),
                                      if (airline != null)
                                        switch (airline.isVirtual) {
                                          true => const Text('Virtual Airline', style: TextStyle(color: Colors.grey),),
                                          false => Text(AppLocalizations.of(context)!.company, style: const TextStyle(color: Colors.grey),),
                                        }
                                    ],
                                  ),
                                  verticalSpace(5),
                                  Row(

                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (flight.flightPlan?.aircraftShort != null && flight.flightPlan?.aircraftShort != '')
                                        FutureBuilder<Aircraft?>(
                                          future: locator<GetAircraftDetailsUseCase>().call(AircraftDetailsParams(aircraftCode: flight.flightPlan!.aircraftShort)),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              var aircraft = snapshot.data;

                                              if (aircraft != null) {
                                                return Flexible(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SelectableText('${aircraft.manufacture} ${aircraft.model}',
                                                        style: const TextStyle(
                                                          color: SftColors.customGrey,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${flight.flightPlan?.aircraftShort}',
                                                        style: TextStyle(
                                                          color: Colors.grey.withValues(alpha: 0.5),
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              } else {
                                                return Flexible(
                                                  child: Text(flight.flightPlan!.aircraftShort,
                                                    style: const TextStyle(
                                                      color: SftColors.customGrey,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                );
                                              }
                                            }

                                            return const SizedBox(
                                              height: 10,
                                              width: 10,
                                              child: CircularProgressIndicator(
                                                color: SftColors.lightGreen,
                                                strokeWidth: 1,
                                              ),
                                            );
                                          },
                                        )
                                      else
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(AppLocalizations.of(context)!.unknownAircraft,
                                                style: const TextStyle(
                                                  color: SftColors.customGrey,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                AppLocalizations.of(context)!.waitingOFP,
                                                style: TextStyle(
                                                  color: Colors.grey.withValues(alpha: 0.5),
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      if (airline != null && !showLogos)
                                        Text(airline.name, style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                                      if (airline != null && showLogos)
                                        (airline.hasCustomLogo == true)
                                            ? CachedNetworkImage(
                                          imageUrl: '${dotenv.get('SFT_SERVER_URL')}/airlines/${airline.icao.toLowerCase()}.png',
                                          width: 130,
                                        )
                                            : CachedNetworkImage(
                                          imageUrl: 'https://daisycon.io/images/airline/?width=300&height=100&iata=${airline.iata}',
                                          width: 130,
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(20,),
                              decoration: BoxDecoration(
                                color: flyingWithoutOfp ? Colors.redAccent.withValues(alpha: 0.3) : SftColors.primaryDark,
                                border: Border(
                                    bottom: BorderSide(
                                      color: SftColors.lightGreen.withValues(alpha: 0.2),
                                    )
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(AppLocalizations.of(context)!.altitude, style: theme.textTheme.titleSmall,),
                                          const SizedBox(height: 5,),
                                          if (flight.altitude >= 10000)
                                            Text('FL${(flight.altitude / 100).round()}',),
                                          if (flight.altitude < 10000)
                                            Text('ALT${flight.altitude.toString()}',),
                                        ],
                                      ),
                                      SizedBox(width: 1,height: 20, child: Container( color: SftColors.lightGreen.withValues(alpha: 0.2),),),
                                      Column(
                                        children: [
                                          Text(AppLocalizations.of(context)!.speed, style: theme.textTheme.titleSmall,),
                                          const SizedBox(height: 5,),
                                          Text('${flight.groundSpeed.toString()} KT',),
                                        ],
                                      ),
                                      SizedBox(width: 1,height: 20, child: Container( color: SftColors.lightGreen.withValues(alpha: 0.2),),),
                                      Column(
                                        children: [
                                          Text(AppLocalizations.of(context)!.heading, style: theme.textTheme.titleSmall,),
                                          const SizedBox(height: 5,),
                                          Text(flight.heading.toString(),)
                                        ],
                                      ),
                                    ],
                                  ),
                                  if (flyingWithoutOfp) Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(AppLocalizations.of(context)!.flyingNoOfp, style: theme.textTheme.bodySmall,),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(20,),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Symbols.flight,
                                        color: SftColors.lightOrange,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 5,),
                                      Text(
                                          AppLocalizations.of(context)!.flightDetails,
                                          style: theme.textTheme.titleMedium
                                      )
                                    ],
                                  ),
                                  verticalSpace(10),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Squawk', style: theme.textTheme.bodySmall,),
                                          Text(flight.transponder, style: theme.textTheme.bodySmall,)
                                        ],
                                      ),
                                      customDivider(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(AppLocalizations.of(context)!.totalDistance, style: theme.textTheme.bodySmall,),
                                          Text(
                                            '${distanceTotal.toString()} nm',
                                            style: theme.textTheme.bodySmall,
                                          ),
                                        ],
                                      ),
                                      customDivider(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(AppLocalizations.of(context)!.distanceTravelled, style: theme.textTheme.bodySmall,),
                                          Text(
                                            '${distanceTravelled.toString()} nm',
                                            style: theme.textTheme.bodySmall,
                                          ),
                                        ],
                                      ),
                                      customDivider(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(AppLocalizations.of(context)!.distanceRemaining, style: theme.textTheme.bodySmall,),
                                          Text(
                                            '${distanceRemaining.toString()} nm',
                                            style: theme.textTheme.bodySmall,
                                          ),
                                        ],
                                      ),
                                      customDivider(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(AppLocalizations.of(context)!.timeToDestination, style: theme.textTheme.bodySmall,),
                                          Text(
                                            (flight.groundSpeed > 50) ? intToTimeLeft(eta, context) : (phase == 'Arrived') ? AppLocalizations.of(context)!.arrived :  AppLocalizations.of(context)!.notAvailable,
                                            style: theme.textTheme.bodySmall,
                                          ),
                                        ],
                                      ),
                                      customDivider(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(AppLocalizations.of(context)!.etaLocal, style: theme.textTheme.bodySmall,),
                                                Text(AppLocalizations.of(context)!.timeSelection(
                                                  ref.read(appConfigProvider).dateType.name == 'local'
                                                      ? AppLocalizations.of(context)!.local
                                                      : 'Zulu',
                                                ),
                                                    style: const TextStyle(color: Colors.white24)
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              if (ref.read(appConfigProvider).dateType == DateType.local) Text(
                                                (flight.groundSpeed > 50 && arrivalAirport != null) ? dateFormat.format(DateTime.now().add(Duration(hours: timeVal[0], minutes: timeVal[1], seconds: timeVal[2]))) : (phase == 'Arrived') ? AppLocalizations.of(context)!.arrived : AppLocalizations.of(context)!.notAvailable,
                                                style: theme.textTheme.bodySmall,
                                              ),
                                              if (ref.read(appConfigProvider).dateType == DateType.zulu) Text(
                                                (flight.groundSpeed > 50 && arrivalAirport != null) ? dateFormat.format(DateTime.now().add(Duration(hours: timeVal[0], minutes: timeVal[1], seconds: timeVal[2])).toUtc()) : (phase == 'Arrived') ? AppLocalizations.of(context)!.arrived : AppLocalizations.of(context)!.notAvailable,
                                                style: theme.textTheme.bodySmall,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                  verticalSpace(20),
                                  Text(
                                    (flight.flightPlan != null && flight.flightPlan?.route != null && flight.flightPlan?.route != '')
                                        ? flight.flightPlan!.route
                                        : AppLocalizations.of(context)!.noOFP,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      height: 1.5,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            ),
                            if (airline != null) Container(
                              padding: const EdgeInsets.all(20,),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Symbols.airlines,
                                        color: SftColors.lightOrange,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 5,),
                                      Text(AppLocalizations.of(context)!.airlineDetails,
                                          style: theme.textTheme.titleMedium
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(AppLocalizations.of(context)!.country, style: theme.textTheme.bodySmall,),
                                      Text(airline.country, style: theme.textTheme.bodySmall),
                                    ],
                                  ),
                                  customDivider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(AppLocalizations.of(context)!.name, style: theme.textTheme.bodySmall,),
                                      Text(airline.name, style: theme.textTheme.bodySmall),
                                    ],
                                  ),
                                  customDivider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(AppLocalizations.of(context)!.callsign, style: theme.textTheme.bodySmall,),
                                      Text(airline.callsign, style: theme.textTheme.bodySmall),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (shouldShowPromos) customDivider(hasBottomMargin: false, hasTopMargin: false),
                      if (shouldShowPromos) bannerAdContainer(_bannerAd..load()),
                    ],
                  );
                }

                if (snapshot.hasError) {
                  //  something went wrong;
                  return NotFoundScreen(message: AppLocalizations.of(context)!.noFlightDetails);
                }

                return const SftLoader();

              },
            );
          },
        ),
      );
    } on FlightNotFoundException catch (_) {
      return NotFoundScreen(message: AppLocalizations.of(context)!.flightDisconnected,);
    } catch (e) {
      return GenericErrorScreen(message: AppLocalizations.of(context)!.errorFlightLoad);
    }
  }

}
