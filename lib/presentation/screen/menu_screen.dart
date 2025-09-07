import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:sim_flights_tracker/core/constants/app_routes.dart';
import 'package:sim_flights_tracker/core/constants/sim_network.dart';
import 'package:sim_flights_tracker/core/state/provider/providers.dart';
import 'package:sim_flights_tracker/presentation/util/space_utils.dart';
import 'package:sim_flights_tracker/presentation/widget/donate_button.dart';

import '../../core/config/i10n/generated/app_localizations.dart';
import '../widget/custom_divider.dart';
import '../widget/menu_item_wide.dart';

class MenuScreen extends ConsumerWidget {
  const MenuScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final interstitialAdvert = ref.read(adsProvider).value?.interstitialAd;
    final simNetwork = ref.read(appConfigProvider).currentSimNetwork;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              children: [
                if (simNetwork == SimNetwork.vatsim) MenuItemWide(title: AppLocalizations.of(context)!.flightsLog, location: AppRoutes.vatsimProfileScreen, description: AppLocalizations.of(context)!.latestHundredFlights, itemIcon: Symbols.note_stack),
                if (simNetwork == SimNetwork.vatsim) customDivider(),
                MenuItemWide(title: AppLocalizations.of(context)!.airportSearch, location: AppRoutes.airportsScreen, itemIcon: Symbols.globe, description: AppLocalizations.of(context)!.searchAirportInformation,),
                customDivider(),
                MenuItemWide(title: AppLocalizations.of(context)!.events, location: AppRoutes.eventsHomeScreen, itemIcon: Symbols.calendar_today, description: AppLocalizations.of(context)!.events,),
                customDivider(),
                MenuItemWide(title: AppLocalizations.of(context)!.settings, location: AppRoutes.settingsScreen, itemIcon: Symbols.settings, description: AppLocalizations.of(context)!.settingsDescription,),
                customDivider(),
                MenuItemWide(title: AppLocalizations.of(context)!.about, location: AppRoutes.aboutScreen, itemIcon: Symbols.info, description: AppLocalizations.of(context)!.aboutAppDescription,),
              ],
            ),
          ),
          customDivider(hasTopMargin: false, hasBottomMargin: false),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (Platform.isAndroid)
                  DonateButton(),
                if (Platform.isAndroid)
                  horizontalSpace(10),
                Expanded(
                  child: OutlinedButton(
                      onPressed: interstitialAdvert == null ? null : () {
                        interstitialAdvert.show();
                        ref.read(adsProvider.notifier).refreshInterstitialAdvert();
                      },
                      child: Text(AppLocalizations.of(context)!.watchAd, overflow: TextOverflow.ellipsis,)
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
