import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sim_flights_tracker/core/constants/date_type.dart';
import 'package:sim_flights_tracker/core/dependency_injection/injection_container.dart';
import 'package:sim_flights_tracker/core/state/provider/providers.dart';
import 'package:sim_flights_tracker/core/theme/colors.dart';
import 'package:sim_flights_tracker/core/theme/spacing.dart';
import 'package:sim_flights_tracker/domain/usecase/events/get_event_details.dart';

import '../../../core/config/i10n/generated/app_localizations.dart';
import '../../../data/entity/_sft_event_summary.dart';
import '../../util/bottom_sheets.dart';
import '../../util/general_utils.dart';
import '../../util/space_utils.dart';
import '../../widget/banner_add_container.dart';
import '../../widget/custom_divider.dart';
import '../../widget/loader.dart';
import '../../widget/sft_widgets.dart';


class EventDetailsScreen extends ConsumerWidget {
  final SftEventSummary eventSummary;
  EventDetailsScreen({super.key, required this.eventSummary});

  final _bannerAd = createBannerAd();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    var currentSimNetwork = ref.read(appConfigProvider).currentSimNetwork;
    var dateType = ref.read(appConfigProvider).dateType;
    var shouldShowPromos = false;

    DateFormat dateTimeFormat = DateFormat('d MMMM HH:mm', Localizations.localeOf(context).toString());
    var theme = Theme.of(context);

    var pendingNotifications = ref.watch(notificationsProvider).pendingNotifications;
    var notificationAlreadySet = pendingNotifications.any((notification) => notification.id == eventSummary.id);

    return Container(
      color: SftColors.primaryDark,
      child: SafeArea(
        child: Scaffold(
          body: FutureBuilder(
            future: locator<GetEventDetailsUseCase>().call(EventDetailsParams(eventId: eventSummary.id, simNetwork: currentSimNetwork)),
            builder: (context, snapshot) {
              if (snapshot.hasData) {

                var event = snapshot.data;

                if (event != null) {
                  var startDate = dateType == DateType.local ?  DateTime.parse(event.startTime).toLocal() :  DateTime.parse(event.startTime).toUtc();
                  var endDate = dateType == DateType.local ?  DateTime.parse(event.endTime).toLocal() :  DateTime.parse(event.endTime).toUtc();

                  return Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            Hero(
                              tag: eventSummary.id,
                              child: CachedNetworkImage(
                                imageUrl: eventSummary.poster,
                              ),
                            ),
                            Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(eventSummary.name, style: theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(dateTimeFormat.format(startDate), style: theme.textTheme.bodySmall,),
                                        Text(' - ', style: theme.textTheme.bodySmall),
                                        Text(dateTimeFormat.format(endDate), style: theme.textTheme.bodySmall,),
                                        Text(' ( ${dateType.name} )', style: theme.textTheme.bodySmall,),
                                      ],
                                    ),
                                    if (event.airports.isNotEmpty) verticalSpace(10),
                                    if (event.airports.isNotEmpty) SizedBox(
                                      height: 20,
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: event.airports.length,
                                        separatorBuilder: (context, index) => horizontalSpace(5,),
                                        itemBuilder: (context, index) => labelPill(
                                          event.airports[index].icao,
                                          theme.textTheme.labelSmall!,
                                          SftColors.primary
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            ),
                            customDivider(),
                            Container(
                              padding: Spacing.standardPaddingInset,
                              child: Text(event.description, style: theme.textTheme.bodyMedium,)
                            ),
                          ],
                        ),
                      ),
                      customDivider(),
                      Container(
                        padding: EdgeInsets.only(
                          left: Spacing.standardPadding, right: Spacing.standardPadding,
                          bottom: Spacing.halfPadding,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios, color: SftColors.lightGreen),
                              onPressed: () => context.pop()
                            ),
                            if (!DateTime.parse(event.startTime).isBefore(DateTime.now()) && DateTime.parse(event.startTime).difference(DateTime.now()) > const Duration(minutes: 15))
                              notificationAlreadySet
                                ? TextButton(
                              child: Row(
                                children: [
                                  const Icon(LineIcons.bellSlash, color: Colors.white),
                                  Text(AppLocalizations.of(context)!.eventRemove),
                                ],
                              ),
                              onPressed: () =>  showCancelEventReminderBottomSheet(context, eventSummary, ref)
                            )
                                : TextButton(
                              child: Row(
                                children: [
                                  const Icon(LineIcons.bell, color: Colors.white),
                                  Text(AppLocalizations.of(context)!.eventAdd),
                                ],
                              ),
                              onPressed: () => showAddEventReminderBottomSheet(context, event, ref),
                            ),
                          ],
                        ),
                      ),
                      if (shouldShowPromos) customDivider(hasBottomMargin: false, hasTopMargin: false),
                      if (shouldShowPromos) bannerAdContainer(_bannerAd..load()),
                    ],
                  );
                }

                return const Text('Error');
              }

              if (snapshot.hasError) {
                return const Text('Error');
              }

              return const SftLoader();
            },
          ),
        ),
      ),
    );
  }
}
