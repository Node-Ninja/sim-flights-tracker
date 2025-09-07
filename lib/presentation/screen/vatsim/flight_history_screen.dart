import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:sim_flights_tracker/core/state/provider/providers.dart';
import 'package:sim_flights_tracker/core/theme/colors.dart';
import 'package:sim_flights_tracker/core/theme/spacing.dart';
import 'package:sim_flights_tracker/presentation/util/bottom_sheets.dart';
import 'package:sim_flights_tracker/presentation/util/space_utils.dart';
import 'package:sim_flights_tracker/presentation/widget/custom_divider.dart';
import 'package:sim_flights_tracker/presentation/widget/navigation/custom_appbar.dart';

import '../../../core/config/i10n/generated/app_localizations.dart';

class FlightHistoryScreen extends ConsumerWidget {
  const FlightHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var theme = Theme.of(context);

    var vatsimFlightsHistory = ref.read(liveDataProvider).vatsimFlightsHistory;
    var vatsimFlightPlanHistory = ref.read(liveDataProvider).vatsimFlightPlanHistory;
    var vatsimUserHours = ref.read(liveDataProvider).vatsimUserHours;
    var vatsimId = ref.read(appConfigProvider).vatsimId;
    var simNetwork = ref.read(appConfigProvider).currentSimNetwork;


    return Scaffold(
      appBar: CustomAppBar(title: Text(AppLocalizations.of(context)!.flightsLog)),
      body: Column(
        children: [
          if (vatsimFlightsHistory.count > 0) Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${AppLocalizations.of(context)!.totalFlightCount}: ${vatsimFlightsHistory.count}', style: theme.textTheme.bodySmall,),
                Text('${AppLocalizations.of(context)!.vatsimId} : $vatsimId', style: theme.textTheme.bodySmall,),
              ],
            ),
          ),
          if (vatsimFlightsHistory.count > 0) customDivider(hasBottomMargin: false, hasTopMargin: false),
          if (vatsimUserHours != null) Container(
            decoration: BoxDecoration(
              color: SftColors.primaryDark,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(0, 10), // changes position of shadow
                  ),
                ]
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: Spacing.quarterPaddingInset,
                    child: Column(
                      children: [
                        Text(AppLocalizations.of(context)!.pilotHours, style: theme.textTheme.titleSmall, textAlign: TextAlign.center,),
                        Text('${vatsimUserHours.pilot}', style: theme.textTheme.bodyLarge,)
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 1,height: 30, child: Container( color: SftColors.lightGreen.withValues(alpha: 0.2),),),
                Expanded(
                  child: Container(
                    padding: Spacing.quarterPaddingInset,
                    child: Column(
                      children: [
                        Text(AppLocalizations.of(context)!.atcHours, style: theme.textTheme.titleSmall, textAlign: TextAlign.center,),
                        Text('${vatsimUserHours.atc}', style: theme.textTheme.bodyLarge,)
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 1,height: 30, child: Container( color: SftColors.lightGreen.withValues(alpha: 0.2),),),
                Expanded(
                  child: Container(
                    padding: Spacing.quarterPaddingInset,
                    child: Column(
                      children: [
                        Text(AppLocalizations.of(context)!.supHours, style: theme.textTheme.titleSmall, textAlign: TextAlign.center,),
                        Text('${vatsimUserHours.sup}', style: theme.textTheme.bodyLarge,)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (vatsimFlightsHistory.count > 0) customDivider(hasBottomMargin: false, hasTopMargin: false),
          if (vatsimFlightsHistory.count > 0) Expanded(
            child: ListView.separated(
              itemCount: vatsimFlightsHistory.items.length,
              separatorBuilder: (ctx, index) => verticalSpace(5),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              itemBuilder: (ctx, index) {
                var item = vatsimFlightsHistory.items[index];
                var flightDuration = AppLocalizations.of(context)!.flightInProgress;

                if (item.end != null) {
                  var difference = item.end!.difference(item.start);
                  flightDuration = (difference.inMinutes < 60)
                      ? '${difference.inMinutes} ${AppLocalizations.of(context)!.minutes}'
                      : '${difference.inHours} ${AppLocalizations.of(context)!.hours}';
                }

                var matchingFlightPlan = vatsimFlightPlanHistory.firstWhereOrNull((element) => element.connectionId == item.id);


                return GestureDetector(
                  onTap: () => matchingFlightPlan != null ? showFlightPlanHistoryBottomSheet(matchingFlightPlan, simNetwork, context) : null,
                  child: Card(
                    elevation: 0,
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          CachedNetworkImage(
                            placeholder: (context, url) => const CircularProgressIndicator(
                              strokeWidth: 1,
                            ),
                            errorWidget: (context, url, err) => Container(
                              width: 30,
                              height: 30,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: const Color(0xff2A9D8F)),
                              ),
                              child: const DecoratedBox(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff2A9D8F)
                                ),
                              ),
                            ),
                            imageUrl: 'https://flightaware.com/images/airline_logos/90p/${(item.callsign.length >= 3) ? item.callsign.substring(0,3) : 'aaa' }.png',
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(width: 20,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(item.callsign, style: theme.textTheme.titleMedium,),
                                Text(flightDuration,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (matchingFlightPlan != null) Row(
                            children: [
                              Text(AppLocalizations.of(context)!.viewDetails, style: theme.textTheme.bodySmall,),
                              horizontalSpace(5),
                              const Icon(
                                Icons.chevron_right,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          ),
          if (vatsimFlightsHistory.count == 0) Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Symbols.history,
                      size: 150,
                    ),
                    Text(AppLocalizations.of(context)!.noFlightHistory,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              ),
            ),
          ),
          if (vatsimUserHours != null) customDivider(hasTopMargin: false, hasBottomMargin: false),
          if (vatsimUserHours != null) customDivider(hasTopMargin: false, hasBottomMargin: false),
        ],
      ),
    );

  }

  void refreshHistory(WidgetRef ref) {
    var vatsimId = ref.read(appConfigProvider).vatsimId;

    if (vatsimId.isNotEmpty) {
      var vatsimIdNumber = int.parse(vatsimId);
      ref.read(liveDataProvider.notifier).loadNetworkHistory(vatsimIdNumber, 0);
    }
  }
}
