import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sim_flights_tracker/core/config/i10n/generated/app_localizations.dart';
import 'package:sim_flights_tracker/core/constants/app_routes.dart';
import 'package:sim_flights_tracker/core/constants/sim_network.dart';
import 'package:sim_flights_tracker/core/state/provider/providers.dart';
import 'package:sim_flights_tracker/core/theme/colors.dart';
import 'package:sim_flights_tracker/core/theme/spacing.dart';
import 'package:sim_flights_tracker/data/entity/_atc_history.dart';
import 'package:sim_flights_tracker/data/entity/_flight_plan_history_item.dart';
import 'package:sim_flights_tracker/data/entity/_flights_history.dart';
import 'package:sim_flights_tracker/presentation/util/bottom_sheets.dart';
import 'package:sim_flights_tracker/presentation/util/space_utils.dart';
import 'package:sim_flights_tracker/presentation/widget/custom_divider.dart';
import 'package:sim_flights_tracker/presentation/widget/loader.dart';

class VatsimProfileScreen extends ConsumerStatefulWidget {
  const VatsimProfileScreen({super.key});

  @override
  ConsumerState<VatsimProfileScreen> createState() => _VatsimProfileScreenState();
}

class _VatsimProfileScreenState extends ConsumerState<VatsimProfileScreen> {

  int selectedList = 0;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var vatsimFlightsHistory = ref.watch(liveDataProvider).vatsimFlightsHistory;
    var vatsimFlightPlanHistory = ref.watch(liveDataProvider).vatsimFlightPlanHistory;
    var vatsimUserHours = ref.watch(liveDataProvider).vatsimUserHours;
    var simNetwork = ref.read(appConfigProvider).currentSimNetwork;
    var vatsimAuthenticated = ref.watch(appConfigProvider.select((state) => state.vatsimAuthenticated));
    var authenticatedUserDetails = ref.watch(appConfigProvider.select((state) => state.authedUserDetails));
    var authenticating = ref.watch(appConfigProvider.select((state) => state.isAuthenticating));
    var atcHistory = ref.read(liveDataProvider.select((state) => state.atcHistory));

    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: authenticating 
        ? Center(
            child: SftLoader(message: 'Authenticating. Please wait',),
          )
        : switch(vatsimAuthenticated && authenticatedUserDetails != null) {
          true =>  SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios),
                      iconSize: 20,
                    ),
                    Text(
                      AppLocalizations.of(context)!.flightsLog,
                      style: theme.textTheme.headlineSmall,
                    ),
                  ]
                ),
                customDivider(hasTopMargin: false),
                Container(
                  padding: Spacing.standardPaddingInset,
                  color: SftColors.primaryDark,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image(
                              image: CachedNetworkImageProvider(
                                'https://avatar.iran.liara.run/username?username=${authenticatedUserDetails?.firstName}+${authenticatedUserDetails?.lastName}&size=100',
                              ),
                              height: 100,
                              width: 100,
                            ),
                          ),
                          horizontalSpace(20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  authenticatedUserDetails?.firstName ?? 'Unknown',
                                  softWrap: true,
                                  maxLines: 3,
                                  style: theme.textTheme.headlineLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      authenticatedUserDetails!.division,
                                      style: theme.textTheme.titleMedium?.copyWith(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    horizontalSpace(5,),
                                    CachedNetworkImage(
                                      width: 15,
                                      imageUrl: 'https://flagsapi.com/${authenticatedUserDetails.countryCode}/flat/24.png',
                                    ),
                                  ],
                                ),
                                Text(
                                  '${authenticatedUserDetails.controllerRating} | ${authenticatedUserDetails.pilotRating}',
                                  style: theme.textTheme.bodySmall,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(20),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: Spacing.quarterPaddingInset,
                              child: Column(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.pilotHours,
                                    style: theme.textTheme.titleSmall,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    '${vatsimUserHours?.pilot ?? 0}',
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 1,
                            height: 30,
                            child: Container(
                              color: SftColors.lightGreen.withValues(alpha: 0.2),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: Spacing.quarterPaddingInset,
                              child: Column(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.atcHours,
                                    style: theme.textTheme.titleSmall,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    '${vatsimUserHours?.atc ?? 0}',
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 1,
                            height: 30,
                            child: Container(
                              color: SftColors.lightGreen.withValues(alpha: 0.2),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: Spacing.quarterPaddingInset,
                              child: Column(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.supHours,
                                    style: theme.textTheme.titleSmall,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    '${vatsimUserHours?.sup ?? 0}',
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                customDivider(hasTopMargin: false, hasBottomMargin: false),
                Stack(
                  children: [
                    AnimatedPositioned(
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeInOut,
                        width: screenWidth / 2,
                        height: 4,
                        bottom: 0,
                        left: _calculateSelectorPosition(context, screenWidth, selectedList),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 100,
                              decoration: BoxDecoration(
                                  color: SftColors.lightOrange.withValues(alpha: 0.8),
                                  borderRadius: const BorderRadius.all(Radius.circular(17))
                              ),
                            ),
                          ],
                        )
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => setState(() {
                              selectedList = 0;
                            }),
                            child: Container(
                              padding: Spacing.standardPaddingInset,
                              child: Text('Flight History', textAlign: TextAlign.center, style: theme.textTheme.bodyLarge,)
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => setState(() {
                              selectedList = 1;
                            }),
                            child: Container(
                                padding: Spacing.standardPaddingInset,
                                child: Text('Control History', textAlign: TextAlign.center,)
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                customDivider(hasTopMargin: false),
                Expanded(
                  child: (selectedList == 0 )
                  ? _buildFlightHistory(
                      context,
                      vatsimFlightsHistory,
                      vatsimFlightPlanHistory,
                      simNetwork
                    )
                  : _buildControllerHistory(context, atcHistory!, ref)
                ),
              ],
            ),
          ),
          false => Container(
            padding: Spacing.standardPaddingInset,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg.png'),
                fit: BoxFit.cover
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppLocalizations.of(context)!.loginWithVatsim,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                verticalSpace(10),
                Text(
                  AppLocalizations.of(context)!.loginWithVatsimLabel,
                  textAlign: TextAlign.center,
                ),
                verticalSpace(20),
                customDivider(),
                verticalSpace(20),
                TextButton(
                  onPressed: () async {
                    var authUri = await ref.read(appConfigProvider.notifier).startAuthentication();

                    // ignore: use_build_context_synchronously
                    context.push(AppRoutes.vatsimAuthStartScreen, extra: authUri);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.authWithVatsim,
                  ),
                ),
                verticalSpace(10),
                OutlinedButton(
                  onPressed: () => context.pop(),
                  child: Text(AppLocalizations.of(context)!.goBack),
                ),
                verticalSpace(50)
              ],
            ),
          ),
        }
    );
  }

  double _calculateSelectorPosition(context, screenWidth, index) {
    return index == 0
        ? 0 : screenWidth / 2;
  }

  Widget _buildFlightHistory(BuildContext context, FlightsHistory vatsimFlightsHistory, List<FlightPlanHistoryItem> vatsimFlightPlanHistory, SimNetwork simNetwork) {
    var theme = Theme.of(context);
    var showLogos = true;

    if (vatsimFlightsHistory.count == 0) {
      return Center(
        child: Text(
          'You have no flight history',
          style: theme.textTheme.bodySmall,
        ),
      );
    }

    return ListView.separated(
      itemCount: vatsimFlightsHistory.items.length,
      separatorBuilder: (ctx, index) => verticalSpace(5),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      itemBuilder: (ctx, index) {
        var item = vatsimFlightsHistory.items[index];
        var flightDuration =
            AppLocalizations.of(context)!.flightInProgress;

        if (item.end != null) {
          var difference = item.end!.difference(item.start);
          flightDuration =
              (difference.inMinutes < 60)
                  ? '${difference.inMinutes} ${AppLocalizations.of(context)!.minutes}'
                  : '${difference.inHours} ${AppLocalizations.of(context)!.hours}';
        }

        var matchingFlightPlan = vatsimFlightPlanHistory
            .firstWhereOrNull(
              (element) => element.connectionId == item.id,
            );

        return GestureDetector(
          onTap:
              () =>
                  matchingFlightPlan != null
                      ? showFlightPlanHistoryBottomSheet(
                        matchingFlightPlan,
                        simNetwork,
                        context,
                      )
                      : null,
          child: SlideInRight(
            child: Card(
              elevation: 0,
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    (showLogos)
                    ?  CachedNetworkImage(
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
                      )
                    : Container(
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
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item.callsign,
                            style: theme.textTheme.titleMedium,
                          ),
                          Text(
                            flightDuration,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (matchingFlightPlan != null)
                      Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.viewDetails,
                            style: theme.textTheme.bodySmall,
                          ),
                          horizontalSpace(5),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildControllerHistory(BuildContext ctx, AtcHistory history, WidgetRef ref) {

    var theme = Theme.of(ctx);

    if (history.count == 0) {
      return Center(
        child: Text(
          'You have no ATC history',
          style: Theme.of(ctx).textTheme.bodySmall,
        ),
      );
    }

    return ListView.separated(
      itemCount: history.items.length,
      separatorBuilder: (ctx, index) => verticalSpace(5),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      itemBuilder: (ctx, index) {
        var item = history.items[index];

        var startTime = DateTime.parse(item.connection.start);
        var endTime = DateTime.parse(item.connection.end);

        var onlineTimeHours = endTime.difference(startTime).inMinutes < 60
          ? '${endTime.difference(startTime).inMinutes} ${AppLocalizations.of(ctx)!.minutes}'
          : '${endTime.difference(startTime).inHours} ${AppLocalizations.of(ctx)!.hours}';

        return GestureDetector(
          onTap: () => showControllerHistoryBottomSheet(context, item, onlineTimeHours, ref),
          child: SlideInLeft(
            child: Card(
              elevation: 0,
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xff2A9D8F),
                        ),
                      ),
                      child: const DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff2A9D8F),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item.connection.callsign,
                            style: theme.textTheme.titleMedium,
                          ),
                          Text(
                            onlineTimeHours,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.viewDetails,
                          style: theme.textTheme.bodySmall,
                        ),
                        horizontalSpace(5),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
