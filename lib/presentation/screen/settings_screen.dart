import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:sim_flights_tracker/core/constants/app_routes.dart';
import 'package:sim_flights_tracker/core/constants/date_type.dart';
import 'package:sim_flights_tracker/core/constants/sim_network.dart';
import 'package:sim_flights_tracker/core/state/provider/providers.dart';
import 'package:sim_flights_tracker/core/theme/colors.dart';
import 'package:sim_flights_tracker/core/theme/spacing.dart';
import 'package:sim_flights_tracker/presentation/widget/donate_button.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../core/config/i10n/generated/app_localizations.dart';
import '../util/bottom_sheets.dart';
import '../util/space_utils.dart';
import '../widget/custom_divider.dart';
import '../widget/navigation/custom_appbar.dart';

class SettingsScreen extends ConsumerWidget {

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var configProvider = ref.watch(appConfigProvider);

    final theme = Theme.of(context);

    final interstitialAdvert = ref.watch(adsProvider.select((state) => state.value?.interstitialAd));

    return Scaffold(
      appBar: CustomAppBar(title: Text(AppLocalizations.of(context)!.settings)),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.standardPadding, vertical: Spacing.halfPadding),
                  margin: EdgeInsets.only(bottom: Spacing.standardMargin),
                  color: SftColors.primary.withValues(alpha: 0.5),
                  child: Row(
                    children: [
                      Icon(Symbols.settings, color: SftColors.customGrey),
                      horizontalSpace(5),
                      Text(
                        AppLocalizations.of(context)!.generalSettings,
                        style: theme.textTheme.titleMedium!.copyWith(color: SftColors.customGrey),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.standardPadding,
                    vertical: Spacing.halfPadding,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Symbols.cell_tower),
                          horizontalSpace(10),
                          Text(AppLocalizations.of(context)!.atcNetwork, style: theme.textTheme.bodySmall),
                        ],
                      ),
                      ToggleSwitch(
                        borderWidth: 2,
                        borderColor: const [SftColors.lightGreen],
                        initialLabelIndex: configProvider.currentSimNetwork.index,
                        totalSwitches: 2,
                        activeBgColor: const [SftColors.lightGreen],
                        inactiveBgColor: theme.primaryColor,
                        animate: true,
                        animationDuration: 400,
                        minHeight: 25,
                        labels: [SimNetwork.vatsim.upperName, SimNetwork.ivao.upperName],
                        onToggle: (index) => ref.read(appConfigProvider.notifier).updateSimNetwork(
                            (index == 0) ? SimNetwork.vatsim : SimNetwork.ivao
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.standardPadding,
                    vertical: Spacing.halfPadding,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Symbols.calendar_clock),
                          horizontalSpace(10),
                          Text(AppLocalizations.of(context)!.dateType, style: theme.textTheme.bodySmall),
                        ],
                      ),
                      ToggleSwitch(
                        borderWidth: 2,
                        borderColor: const [SftColors.lightGreen],
                        initialLabelIndex: (configProvider.dateType == DateType.local) ? 0 : 1,
                        totalSwitches: 2,
                        activeBgColor: const [SftColors.lightGreen],
                        inactiveBgColor: theme.primaryColor,
                        animate: true,
                        animationDuration: 400,
                        minHeight: 25,
                        labels: [AppLocalizations.of(context)!.local, 'Zulu'],
                        onToggle: (index) => ref.read(appConfigProvider.notifier).updateDateType(
                            (index == 0) ? DateType.local : DateType.zulu
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.standardPadding,
                    vertical: Spacing.halfPadding,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Symbols.settings_applications),
                          horizontalSpace(10),
                          Text(AppLocalizations.of(context)!.navbarStyle, style: theme.textTheme.bodySmall, overflow: TextOverflow.ellipsis,),
                        ],
                      ),
                      ToggleSwitch(
                        borderWidth: 2,
                        borderColor: const [SftColors.lightGreen],
                        initialLabelIndex: (configProvider.navbarType == 'reveal') ? 0 : 1,
                        totalSwitches: 2,
                        activeBgColor: const [SftColors.lightGreen],
                        inactiveBgColor: theme.primaryColor,
                        animate: true,
                        animationDuration: 400,
                        minHeight: 25,
                        labels: const ['Reveal', 'Slide'],
                        onToggle: (index) => ref.read(appConfigProvider.notifier).updateNavbarType(
                            (index == 0) ? 'reveal' : 'slide'
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.standardPadding,
                    vertical: Spacing.halfPadding,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Symbols.language),
                          horizontalSpace(10),
                          Text(AppLocalizations.of(context)!.language, style: theme.textTheme.bodySmall),
                        ],
                      ),
                      Consumer(
                        builder: (_, ref, __) {
                          var currentLanguage = ref.watch(appConfigProvider.select((state) => state.currentLanguage));

                          return GestureDetector(
                            onTap: () => showLanguageSelectBottomSheet(context, ref),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              width: 144,
                              decoration: BoxDecoration(
                                border: Border.all(color: SftColors.lightGreen),
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CachedNetworkImage(
                                        width: 15,
                                        imageUrl: 'https://flagsapi.com/${currentLanguage.countryCode}/flat/24.png',
                                      ),
                                      horizontalSpace(5),
                                      Text(currentLanguage.language),
                                    ],
                                  ),
                                  const Icon(Symbols.expand_more),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                if (configProvider.currentSimNetwork == SimNetwork.vatsim) Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.standardPadding,
                    vertical: Spacing.halfPadding,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Symbols.verified_user),
                          horizontalSpace(10),
                          Text(AppLocalizations.of(context)!.vatsimId, style: theme.textTheme.bodySmall),
                        ],
                      ),
                      SizedBox(
                        width: 150,
                        child: TextButton(

                          onPressed: () {
                            if (configProvider.vatsimAuthenticated) {
                              ref.read(appConfigProvider.notifier).logOutAuth();
                            } else {
                              context.replace(AppRoutes.vatsimProfileScreen);
                            }
                          },
                          child: (configProvider.vatsimAuthenticated)
                            ? Column(children: [Text(AppLocalizations.of(context)!.logout, style: TextStyle(fontWeight: FontWeight.bold),), Text(configProvider.vatsimId,)],)
                            : Text(AppLocalizations.of(context)!.authWithVatsim, textAlign: TextAlign.center,),
                        ),
                      ),
                    ],
                  ),
                ),
                customDivider(hasBottomMargin: false),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.standardPadding, vertical: Spacing.halfPadding),
                  margin: EdgeInsets.only(bottom: Spacing.standardMargin),
                  color: SftColors.primary.withValues(alpha: 0.5),
                  child: Row(
                    children: [
                      Icon(Symbols.developer_mode, color: SftColors.customGrey),
                      horizontalSpace(5),
                      Text(
                        AppLocalizations.of(context)!.supportTheApp,
                        style: theme.textTheme.titleMedium!.copyWith(color: SftColors.customGrey),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.supportApp,
                        style: theme.textTheme.bodySmall,
                        textAlign: TextAlign.justify,
                      ),
                      verticalSpace(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (Platform.isAndroid)
                            DonateButton(),
                          if (Platform.isAndroid)
                            horizontalSpace(10),
                          Expanded(
                            child: Consumer(
                              builder:
                                  (_, ref, __) => OutlinedButton(
                                    onPressed:
                                        interstitialAdvert == null
                                            ? null
                                            : () {
                                              interstitialAdvert.show();
                                              ref.read(adsProvider.notifier).refreshInterstitialAdvert();
                                            },
                                    child: Text(AppLocalizations.of(context)!.watchAd, overflow: TextOverflow.ellipsis),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
