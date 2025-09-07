import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sim_flights_tracker/core/constants/patterns.dart';
import 'package:sim_flights_tracker/core/constants/sim_network.dart';
import 'package:sim_flights_tracker/core/state/provider/providers.dart';
import 'package:sim_flights_tracker/presentation/util/general_utils.dart';

import '../../core/config/i10n/generated/app_localizations.dart';
import '../util/space_utils.dart';
import '../widget/banner_add_container.dart';
import '../widget/common_search_bar.dart';
import '../widget/custom_divider.dart';
import '../widget/error_widget.dart';
import '../widget/flight_teaser.dart';

class FlightsFilterScreen extends StatelessWidget {
  FlightsFilterScreen({super.key});

  final _bannerAd = createBannerAd();

  @override
  Widget build(BuildContext context) {
    var shouldShowPromos = false;

    return SafeArea(
      child: Scaffold(
        body: Consumer(
          builder: (_, ref, __) {
            var currentSimNetwork = ref.read(appConfigProvider).currentSimNetwork;
            var filteredVatsimFlights = ref.watch(liveDataProvider.select((state) => state.filteredVatsimFlights));
            var filteredIvaoFlights = ref.watch(liveDataProvider.select((state) => state.filteredIvaoFlights));

            var ivaoSearchQuery = ref.watch(liveDataProvider).ivaoFlightsSearchQuery;
            var vatsimSearchQuery = ref.watch(liveDataProvider).vatsimFlightsSearchQuery;

            var currentFlights = switch(currentSimNetwork) {
              SimNetwork.vatsim => filteredVatsimFlights,
              SimNetwork.ivao => filteredIvaoFlights
            };

            var searchQuery = switch(currentSimNetwork) {
              SimNetwork.vatsim => vatsimSearchQuery,
              SimNetwork.ivao => ivaoSearchQuery
            };

            return Column(
              children: [
                CommonSearchBar(
                  searchField: TextFormField(
                    initialValue: searchQuery,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.searchWithFlightNumber,
                      suffixIcon: const Icon(LineIcons.search,),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(ValidationPatterns.alphaNumeric),
                    ],
                    onChanged: (value) {
                      ref.read(liveDataProvider.notifier).filterFlights(value.trim(), currentSimNetwork);
                    },
                  ),
                ),
                switch (currentFlights.length) {
                  0 => CustomErrorWidget(errorMessage: AppLocalizations.of(context)!.noFlightsQuery,),
                  _ => Expanded(
                    child: ListView.separated(
                      itemCount: currentFlights.length,
                      separatorBuilder: (_, __) => verticalSpace(0),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                      itemBuilder: (context, index) => FlightTeaser(flight: currentFlights[index], simNetwork: currentSimNetwork),
                    ),
                  ),
                },
                if (shouldShowPromos) customDivider(hasBottomMargin: false, hasTopMargin: false),
                if (shouldShowPromos) bannerAdContainer(_bannerAd..load()),
              ],
            );
          },
        )
      ),
    );
  }
}
