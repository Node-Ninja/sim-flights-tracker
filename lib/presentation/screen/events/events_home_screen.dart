import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timeline_calendar/timeline/model/calendar_options.dart';
import 'package:flutter_timeline_calendar/timeline/model/day_options.dart';
import 'package:flutter_timeline_calendar/timeline/model/headers_options.dart';
import 'package:flutter_timeline_calendar/timeline/utils/calendar_types.dart';
import 'package:flutter_timeline_calendar/timeline/widget/timeline_calendar.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:sim_flights_tracker/core/constants/sim_network.dart';
import 'package:sim_flights_tracker/core/state/provider/providers.dart';
import 'package:sim_flights_tracker/core/theme/colors.dart';
import 'package:sim_flights_tracker/core/theme/spacing.dart';
import 'package:sim_flights_tracker/presentation/util/general_utils.dart';

import '../../../core/config/i10n/generated/app_localizations.dart';
import '../../util/space_utils.dart';
import '../../widget/banner_add_container.dart';
import '../../widget/custom_divider.dart';
import '../../widget/event_teaser.dart';
import '../../widget/loader.dart';
import '../../widget/navigation/custom_appbar.dart';

class EventsHomeScreen extends ConsumerStatefulWidget {
  const EventsHomeScreen({super.key});

  @override
  ConsumerState<EventsHomeScreen> createState() => _EventsHomeScreenState();
}

class _EventsHomeScreenState extends ConsumerState<EventsHomeScreen> {

  final _bannerAd = createBannerAd();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var shouldShowPromos = false;
    var currentSimNetwork = ref.read(appConfigProvider).currentSimNetwork;

    var theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(title: Text('${currentSimNetwork.upperName} ${AppLocalizations.of(context)!.events}')),
      body: Column(
        children: [
          Consumer(
            builder: (_, reference, __) {

              // var filteredEvents = (currentSimNetwork == SimNetwork.vatsim)
              //     ? reference.read(eventsProvider).
              //     : eventsProvider.filteredIvaoEvents;

              return reference.watch(eventsProvider).when(
                data: (data) {
                  var filteredEvents = (currentSimNetwork == SimNetwork.vatsim)
                      ? data.filteredVatsimEvents
                      : data.filteredIvaoEvents;

                  return Expanded(
                      child: switch(filteredEvents.length) {
                        0 =>
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Symbols.event_busy, size: 100,),
                                  Text(AppLocalizations.of(context)!.noEvents,
                                    style: theme.textTheme.titleLarge,),
                                  Text(AppLocalizations.of(context)!
                                      .noEventsPlanned, style: theme.textTheme
                                      .bodyMedium),
                                ],
                              ),
                            ),
                        _ =>
                            ListView.separated(
                              padding: EdgeInsets.symmetric(
                                vertical: Spacing.halfPadding,
                                horizontal: Spacing.quarterPadding,
                              ),
                              itemCount: filteredEvents.length,
                              separatorBuilder: (_, __) => verticalSpace(5),
                              itemBuilder: (context, index) =>
                                  EventTeaser(event: filteredEvents[index]),
                            ),
                      }
                  );
                },
                error: (err, st) => const SftLoader(),
                loading: () => const SftLoader(),
              );
            }
          ),
          customDivider(),
          TimelineCalendar(
            calendarLanguage: ref.read(appConfigProvider).currentLocale.toString(),
            calendarType: CalendarType.GREGORIAN,
            calendarOptions: CalendarOptions(
              viewType: ViewType.DAILY,
              headerMonthElevation: 0,
              headerMonthShape: const Border(),
              bottomSheetBackColor: SftColors.primaryDark,
              headerMonthBackColor: SftColors.primaryDark,
              headerMonthShadowColor: SftColors.primaryDark,
            ),
            headerOptions: HeaderOptions(
              backgroundColor: SftColors.primaryDark,
              headerTextColor: SftColors.customGrey,
              calendarIconColor: SftColors.lightGreen,
              monthStringType: MonthStringTypes.FULL,
              navigationColor: SftColors.lightGreen,
              resetDateColor: SftColors.lightOrange,

            ),
            dayOptions: DayOptions(
              compactMode: false,
              selectedBackgroundColor: SftColors.lightOrange,
              disableFadeEffect: true,
              weekBackgroundColor: SftColors.primaryDark,
              unselectedTextColor: Colors.grey,
              weekDayUnselectedColor: SftColors.customGrey,
            ),
            onChangeDateTime: (date) => ref.read(eventsProvider.notifier).filterByDate(date.toDateTime().toLocal(), currentSimNetwork),
            onDateTimeReset: (date) => ref.read(eventsProvider.notifier).filterByDate(date.toDateTime().toLocal(), currentSimNetwork),
            onMonthChanged: (date) => ref.read(eventsProvider.notifier).filterByDate(date.toDateTime().toLocal(), currentSimNetwork),
            onYearChanged: (date) => ref.read(eventsProvider.notifier).filterByDate(date.toDateTime().toLocal(), currentSimNetwork),
          ),
          if (shouldShowPromos) customDivider(hasBottomMargin: false, hasTopMargin: false),
          if (shouldShowPromos) bannerAdContainer(_bannerAd..load()),
        ],
      ),
    );
  }
}
