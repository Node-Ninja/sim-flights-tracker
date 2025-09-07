import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:sim_flights_tracker/core/constants/patterns.dart';
import 'package:sim_flights_tracker/core/dependency_injection/injection_container.dart';
import 'package:sim_flights_tracker/domain/usecase/airports/get_airport_metar.dart';

import '../../core/config/i10n/generated/app_localizations.dart';
import '../../core/theme/colors.dart';
import '../../core/utils.dart';
class Metar extends StatelessWidget {
  final String icaoCode;

  const Metar({super.key, required this.icaoCode});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return FutureBuilder(
      future: locator<GetAirportMetarUseCase>().call(AirportMetarParams(icaoId: icaoCode)),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != 'No metar available for this airport.' && snapshot.data != null && snapshot.data != 'VATSIM Metar Service') {

            String? temperature = ValidationPatterns.dewTemperature.firstMatch(snapshot.data!)?.group(0);
            String? altimeter = AppLocalizations.of(context)!.notAvailable;

            String? euroAltm = ValidationPatterns.euroAltimeter.firstMatch(snapshot.data!)?.group(0);
            String? amerAltm = ValidationPatterns.americaAltimeter.firstMatch(snapshot.data!)?.group(0);

            //  decode meter;
            if (euroAltm != null) {
              //  format euro altimeter;
              altimeter = 'QNH ${euroAltm.replaceAll('Q', '')}';
            } else if (amerAltm != null) {
              var matches = RegExp(r'(\d{2})').allMatches(amerAltm).toList();
              altimeter = '${matches[0].group(0)}.${matches[1].group(0)} Hg';
            }

            return Row(
              children: [
                Lottie.asset('assets/lottie/wind2.json',
                  height: 100,
                  frameRate: FrameRate.max,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                  right: 10,
                                ),
                                child: Column(
                                  children: [
                                    const Icon(LineIcons.wind, color: Colors.grey,),
                                    const SizedBox(height: 5,),
                                    Text(extractWindFromMetar(snapshot.data!, context),
                                      style: const TextStyle(
                                        color: SftColors.customGrey
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(height: 40, width: 1, color: SftColors.lightGreen.withValues(alpha: 0.2),),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    const Icon(LineIcons.globeWithAfricaShown, color: Colors.grey,),
                                    const SizedBox(height: 5,),
                                    Text(altimeter,
                                      style: const TextStyle(
                                        color: SftColors.customGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(height: 40, width: 1, color: SftColors.lightGreen.withValues(alpha: 0.2),),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    const Icon(LineIcons.thermometerEmpty, color: Colors.grey,),
                                    const SizedBox(height: 5,),
                                    Text('Temp: ${(temperature != null) ? temperature.split('/')[0]: '0'}°C',
                                      style: const TextStyle(
                                        color: SftColors.customGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 20,
                          top: 5,
                        ),
                        child: Center(
                          child: Text(snapshot.data ?? '',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Text(AppLocalizations.of(context)!.noMetar, style: theme.textTheme.bodySmall,),
            );
          }
          // return Text(snapshot.data, style: TextStyle(color: _customColors['customGrey'], fontSize: 14,),);
        } else if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Text(AppLocalizations.of(context)!.noMetar, style: theme.textTheme.bodySmall,),
          );
        } else {
          return const Padding(
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
          );
        }
      },
    );
  }
}
