import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sim_flights_tracker/core/constants/controller_type.dart';
import 'package:sim_flights_tracker/core/theme/colors.dart';
import 'package:sim_flights_tracker/core/theme/spacing.dart';
import 'package:sim_flights_tracker/presentation/widget/banner_add_container.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../core/config/i10n/generated/app_localizations.dart';
import '../../core/constants/app_routes.dart';
import '../../core/constants/sim_network.dart';
import '../../core/data/mock.dart';
import '../../core/state/provider/providers.dart';
import '../util/general_utils.dart';
import '../util/space_utils.dart';
import '../widget/custom_divider.dart';
import '../widget/flight_teaser.dart';
import '../widget/sft_widgets.dart';

class LandingScreen extends ConsumerWidget {
  LandingScreen({super.key});

  final _bannerAd = createBannerAd();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var shouldShowPromos =false;

    ThemeData theme = Theme.of(context);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Consumer(
                  builder: (_, ref, __) {
                    return Container(
                      height: MediaQuery.sizeOf(context).shortestSide > 599 ? 500: 300,
                      decoration: BoxDecoration(
                        color: SftColors.primary,
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/0/00/Lesotho_Defence_Airwing.jpg/960px-Lesotho_Defence_Airwing.jpg',
                          ),
                          fit: BoxFit.cover,
                          alignment: Alignment.bottomCenter,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                              left: Spacing.quarterPadding,
                              right: Spacing.standardPadding,
                              bottom: Spacing.halfPadding,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  SftColors.primaryDark,
                                  SftColors.primaryDark.withValues(alpha: 0.9),
                                  Colors.transparent,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Image.asset(
                                  'assets/sft_transparent.png',
                                  width: 100,
                                  height: 100,
                                ),
                                Text('@Commons', style: theme.textTheme.labelSmall,),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Spacing.standardPadding,
                                vertical: Spacing.halfPadding
                            ),
                            color: SftColors.primary,
                            child: Consumer(
                                builder: (context, ref, _) {
                                  var currentSimNetwork = ref.read(appConfigProvider).currentSimNetwork;
                                  var vatsimFlights = ref.watch(liveDataProvider.select((state) => state.vatsimFlights));
                                  var vatsimControllers = ref.watch(liveDataProvider.select((state) => state.vatsimControllers));
                                  var ivaoFlights = ref.watch(liveDataProvider.select((state) => state.ivaoFlights));
                                  var ivaoControllers = ref.watch(liveDataProvider.select((state) => state.ivaoControllers));
                                  var vatsimObserverCount = vatsimControllers.where((c) => c.callsign.contains(ControllerType.observer.code)).length;

                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(AppLocalizations.of(context)!.network, style: theme.textTheme.titleSmall,),
                                          Text(currentSimNetwork.upperName, style: theme.textTheme.bodyMedium,),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(AppLocalizations.of(context)!.flights, style: theme.textTheme.titleSmall,),
                                          switch (currentSimNetwork) {
                                            SimNetwork.vatsim => Text('${vatsimFlights.length}', style: theme.textTheme.bodyMedium,),
                                            SimNetwork.ivao => Text('${ivaoFlights.length}', style: theme.textTheme.bodyMedium,),
                                          }
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(AppLocalizations.of(context)!.controllers, style: theme.textTheme.titleSmall,),
                                          switch (currentSimNetwork) {
                                            SimNetwork.vatsim => Text('${vatsimControllers.length}', style: theme.textTheme.bodyMedium,),
                                            SimNetwork.ivao => Text('${ivaoControllers.length}', style: theme.textTheme.bodyMedium,),
                                          }
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(AppLocalizations.of(context)!.observers, style: theme.textTheme.titleSmall,),
                                          switch (currentSimNetwork) {
                                            SimNetwork.vatsim => Text('$vatsimObserverCount', style: theme.textTheme.bodyMedium,),
                                            SimNetwork.ivao => Text(AppLocalizations.of(context)!.unknown, style: theme.textTheme.bodyMedium,),
                                          }
                                        ],
                                      ),
                                    ],
                                  );
                                }
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                ),
                Container(
                    padding: Spacing.standardPaddingInset.copyWith(right: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.events, style: theme.textTheme.titleMedium,),
                            horizontalSpace(5),
                            Consumer(builder: (context, ref, _) => labelPill(
                                ref.read(appConfigProvider).currentSimNetwork.upperName,
                                theme.textTheme.labelMedium as TextStyle, SftColors.primary
                            )),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => context.push(AppRoutes.eventsHomeScreen,),
                          child: Container(
                            decoration: BoxDecoration(
                                color: SftColors.primaryDark,
                                border: Border(
                                  left: BorderSide(color: SftColors.lightGreen.withValues(alpha: 0.3),),
                                  top: BorderSide(color: SftColors.lightGreen.withValues(alpha: 0.3),),
                                  bottom: BorderSide(color: SftColors.lightGreen.withValues(alpha: 0.3),),
                                ),
                                borderRadius: const BorderRadius.horizontal(left: Radius.circular(20))
                            ),
                            padding: Spacing.halfPaddingInset,
                            width: 120,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(AppLocalizations.of(context)!.viewMore, style: theme.textTheme.bodyMedium,),
                                const Icon(
                                  Icons.chevron_right,
                                  color: SftColors.lightGreen,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                ),
                Consumer(
                    builder: (context, ref, _) {
                      var allEventsProvider = ref.watch(eventsProvider);

                      var events = ref.read(appConfigProvider).currentSimNetwork == SimNetwork.vatsim
                          ? allEventsProvider.value?.allVatsimEvents ?? []
                          : allEventsProvider.value?.allIvaoEvents ?? [];



                      if (allEventsProvider.isLoading || events.isEmpty) {
                        return Skeletonizer(
                          enabled: events.isEmpty,
                          effect: const ShimmerEffect(
                              baseColor: SftColors.primary,
                              highlightColor: SftColors.primaryDark
                          ),
                          child: SizedBox(
                            height: 160,
                            child: ListView.separated(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (_, __) => horizontalSpace(10),
                              itemCount: 5,
                              itemBuilder: (context, index) => eventTeaserSquare(
                                  context,
                                  Mock.mockEventSummary,
                                  theme.textTheme.titleSmall!,
                                  theme.textTheme.bodySmall!,
                                  ref
                              ),
                            ),
                          ),
                        );
                      }

                      return SizedBox(
                        height: 160,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (_, __) => horizontalSpace(10),
                          itemCount: events.take(5).toList().length,
                          itemBuilder: (context, index) => eventTeaserSquare(
                              context,
                              events[index],
                              theme.textTheme.titleSmall!,
                              theme.textTheme.bodySmall!,
                              ref
                          ),
                        ),
                      );
                    }
                ),
                verticalSpace(10),
                Container(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 20,
                        left: 20
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(AppLocalizations.of(context)?.flights ?? 'Flights', style: theme.textTheme.titleMedium,),
                            horizontalSpace(5),
                            Consumer(builder: (context, ref, _) => labelPill(ref.read(appConfigProvider).currentSimNetwork.upperName, theme.textTheme.labelMedium as TextStyle, SftColors.primary)),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => context.go(AppRoutes.flightsScreen),
                          child: Container(
                            decoration: BoxDecoration(
                                color: SftColors.primaryDark,
                                border: Border(
                                  left: BorderSide(color: SftColors.lightGreen.withValues(alpha: 0.3),),
                                  top: BorderSide(color: SftColors.lightGreen.withValues(alpha: 0.3),),
                                  bottom: BorderSide(color: SftColors.lightGreen.withValues(alpha: 0.3),),
                                ),
                                borderRadius: const BorderRadius.horizontal(left: Radius.circular(20))
                            ),
                            padding: Spacing.halfPaddingInset,
                            width: 120,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(AppLocalizations.of(context)!.viewMore, style: theme.textTheme.bodyMedium,),
                                const Icon(
                                  Icons.chevron_right,
                                  color: SftColors.lightGreen,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                Consumer(
                  builder: (context, ref, _) {
                    var vatsimFlights = ref.watch(liveDataProvider.select((state) => state.vatsimFlights));
                    var ivaoFlights = ref.watch(liveDataProvider.select((state) => state.ivaoFlights));
                    var currentSimNetwork = ref.read(appConfigProvider).currentSimNetwork;

                    var shouldEnableShimmer = currentSimNetwork == SimNetwork.vatsim
                        ? vatsimFlights.isEmpty
                        : ivaoFlights.isEmpty;

                    if (shouldEnableShimmer) {
                      return Skeletonizer(
                        enabled: shouldEnableShimmer,
                        effect: const ShimmerEffect(
                            baseColor: SftColors.primary,
                            highlightColor: SftColors.primaryDark
                        ),
                        child: Column(
                          children: [
                            for (var i = 0; i < 5; i++)
                              FlightTeaser(
                                  flight: Mock.mockFlightSummary,
                                  simNetwork: SimNetwork.vatsim
                              ),
                          ],
                        ),
                      );
                    }

                    var vatsimFlightsExtract = vatsimFlights.take(10).toList();
                    var ivaoFlightsExtract = ivaoFlights.take(10).toList();

                    List<Widget> flightsExtract = [
                      if (currentSimNetwork == SimNetwork.vatsim)
                        for (var ft in vatsimFlightsExtract)
                          FlightTeaser(flight: ft, simNetwork: currentSimNetwork),
                      if (currentSimNetwork == SimNetwork.ivao)
                        for (var ft in ivaoFlightsExtract)
                          FlightTeaser(flight: ft, simNetwork: currentSimNetwork),
                    ];

                    return Column(
                      children: [...flightsExtract],
                    );
                  },
                ),
                verticalSpace(10),
              ],
            )
          ),
          if (shouldShowPromos) customDivider(hasBottomMargin: false, hasTopMargin: false),
          if (shouldShowPromos) bannerAdContainer(_bannerAd..load()),
        ],
      ),
    );
  }
}
