import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sim_flights_tracker/core/constants/controller_type.dart';
import 'package:sim_flights_tracker/core/constants/patterns.dart';
import 'package:sim_flights_tracker/core/extensions/string_extensions.dart';
import 'package:sim_flights_tracker/core/state/provider/providers.dart';
import 'package:sim_flights_tracker/core/theme/colors.dart';
import 'package:sim_flights_tracker/core/theme/spacing.dart';
import 'package:sim_flights_tracker/presentation/util/bottom_sheets.dart';
import 'package:sim_flights_tracker/presentation/util/general_utils.dart';
import 'package:sim_flights_tracker/presentation/util/space_utils.dart';

import '../../core/config/i10n/generated/app_localizations.dart';
import '../../core/constants/sim_network.dart';
import '../../core/utils.dart';
import '../../data/entity/_air_traffic_control_sector.dart';
import '../widget/banner_add_container.dart';
import '../widget/common_search_bar.dart';
import '../widget/custom_divider.dart';
import '../widget/error_widget.dart';

class ControllersScreen extends StatelessWidget {
  ControllersScreen({super.key});

  final _bannerAd = createBannerAd();

  @override
  Widget build(BuildContext context) {
    var shouldShowPromos = false;
    
    var theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: Consumer(
          builder: (_, ref, __) {
            var currentSimNetwork = ref.read(appConfigProvider).currentSimNetwork;
            var airportData = ref.read(appConfigProvider).airports;
            var atcSectors = ref.read(appConfigProvider).airTrafficControlSectors;

            var filteredVatsimControllers = ref.watch(liveDataProvider.select((state) => state.filteredVatsimControllers));
            var filteredIvaoControllers = ref.watch(liveDataProvider.select((state) => state.filteredIvaoControllers));

            var ivaoSearchQuery = ref.watch(liveDataProvider).ivaoControllersSearchQuery;
            var vatsimSearchQuery = ref.watch(liveDataProvider).vatsimControllersSearchQuery;

            var currentControllers = switch(currentSimNetwork) {
              SimNetwork.ivao => filteredIvaoControllers,
              SimNetwork.vatsim => filteredVatsimControllers
            };

            var searchQuery = switch(currentSimNetwork) {
              SimNetwork.ivao => ivaoSearchQuery,
              SimNetwork.vatsim => vatsimSearchQuery
            };

            return Column(
              children: [
                CommonSearchBar(
                  searchField: TextFormField(
                    initialValue: searchQuery,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.searchATC,
                      suffixIcon: const Icon(LineIcons.search,),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(ValidationPatterns.alphaNumeric),
                    ],
                    onChanged: (value) {
                      ref.read(liveDataProvider.notifier).filterControllers(value.trim(), currentSimNetwork);
                    },
                  ),
                ),
                switch (currentControllers.length) {
                  0 => CustomErrorWidget(errorMessage: AppLocalizations.of(context)!.noControllers,),
                  _ => Expanded(
                    child: ListView.separated(
                      separatorBuilder: (_, __) => verticalSpace(5),
                      padding: EdgeInsets.symmetric(vertical: Spacing.halfPadding),
                      itemCount: currentControllers.length,
                      itemBuilder: (context, index) {
                        var controllerIcao = currentControllers[index].callsign.takeFirst(4);
                        var controllerAirport = airportData.firstWhereOrNull((airport) => airport.identification == controllerIcao);
                        String? airportName;

                        AirTrafficControlSector? sectorName;

                        if (currentControllers[index].callsign.contains(ControllerType.center.code)) {
                          //  attempt to fetch sector name;
                          var identityRecord = getCleanCallSignAndBoundaryName(currentControllers[index].callsign);

                          sectorName = atcSectors.firstWhereOrNull(
                                  (element) => element.callsign == identityRecord.$1 || element.boundary == identityRecord.$2
                          );
                        }

                        if (controllerAirport != null) airportName = controllerAirport.name.replaceAll('Airport', '');

                        return GestureDetector(
                          onTap: () {
                            var controllerType = currentControllers[index].callsign.takeLast(3);

                            if (controllerType == 'CTR') {
                              showAreaControllerDetailsBottomSheet(currentControllers[index], currentSimNetwork, sectors: ref.read(appConfigProvider).airTrafficControlSectors);
                            } else {
                              showGeneralControllerBottomSheet(currentControllers[index], currentSimNetwork, airports: controllerAirport != null ? [controllerAirport] : airportData);
                            }
                          },
                          child: Card(
                            elevation: 0,
                            color: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('${sectorName?.name ?? airportName ?? currentControllers[index].callsign} ${currentControllers[index].facility}',
                                          style: theme.textTheme.titleMedium,
                                        ),
                                        Text(double.parse(currentControllers[index].frequency).toStringAsFixed(3),
                                          style: TextStyle(
                                            color: SftColors.lighterGrey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.chevron_right,
                                      ),
                                      // Text(double.parse(currentControllers[index].frequency).toStringAsFixed(3),
                                      //   style: theme.textTheme.bodySmall,
                                      // )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                },
                if (shouldShowPromos) customDivider(hasBottomMargin: false, hasTopMargin: false),
                if (shouldShowPromos) bannerAdContainer(_bannerAd..load()),
              ],
            );
          }
        ),
      ),
    );
  }
}
