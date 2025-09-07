import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sim_flights_tracker/core/constants/app_routes.dart';
import 'package:sim_flights_tracker/core/constants/date_type.dart';
import 'package:sim_flights_tracker/core/state/provider/providers.dart';

import '../../core/config/i10n/generated/app_localizations.dart';
import '../../data/entity/_sft_event_summary.dart';
import '../util/space_utils.dart';

class EventTeaser extends ConsumerWidget {
  final SftEventSummary event;

  const EventTeaser({super.key, required this.event});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var theme = Theme.of(context);
    DateFormat timeFormat = DateFormat('HH:mm', Localizations.localeOf(context).toString());
    DateTime startDate = (ref.read(appConfigProvider).dateType == DateType.local)
        ? event.startTime.toLocal()
        : event.startTime.toUtc();

    DateTime endDate = (ref.read(appConfigProvider).dateType == DateType.local)
      ? event.endTime.toLocal()
      : event.endTime.toUtc();

    String status = eventStatus(startDate, endDate, context);

    return GestureDetector(
      onTap: () => context.push(AppRoutes.eventDetailScreen, extra: event),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                LineIcons.calendarCheck,
              ),
              horizontalSpace(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(event.name, style: theme.textTheme.titleSmall, overflow: TextOverflow.ellipsis,),
                    Text(status, style: theme.textTheme.bodyMedium,),
                    Text('${timeFormat.format(startDate)} - ${timeFormat.format(endDate)}', style: theme.textTheme.labelSmall,),
                  ],
                ),
              ),
              horizontalSpace(10),
              const Icon(
                Icons.chevron_right,
              )
            ],
          ),
        ),
      ),
    );
  }

  String eventStatus(DateTime start, DateTime end, BuildContext context) {
    var now = DateTime.now().toLocal();

    if (now.compareTo(start) == -1) {
      return AppLocalizations.of(context)!.hasNotStarted;
    } else if (now.compareTo(start) == 0) {
      return AppLocalizations.of(context)!.startingNow;
    } else {
      if (now.compareTo(end) == -1) {
        return AppLocalizations.of(context)!.inProgress;
      } else if (now.compareTo(end) == 0) {
        return AppLocalizations.of(context)!.endingNow;
      } else {
        return AppLocalizations.of(context)!.hasEnded;
      }
    }
  }
}
