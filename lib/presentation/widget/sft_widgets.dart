import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sim_flights_tracker/core/state/provider/providers.dart';

import '../../core/constants/app_routes.dart';
import '../../core/constants/date_type.dart';
import '../../core/theme/colors.dart';
import '../../data/entity/_sft_event_summary.dart';
import '../util/space_utils.dart';


Widget customPill(String text, Color borderColor, TextStyle style) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      border: Border.all(color: borderColor),
      borderRadius: const BorderRadius.all(Radius.circular(15)),
    ),
    child: Text(text, style: style,),
  );
}

Widget labelPill(String text, TextStyle style, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.2),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 0), // changes position of shadow
        ),
      ]
    ),
    child: Center(
        child: Row(
          children: [
            Text(text,
              style: style
            ),
          ],
        )
    ),
  );
}

Widget eventTeaserSquare(BuildContext context, SftEventSummary eventSummary, TextStyle titleStyle, TextStyle dateStyle, WidgetRef ref) {
  var timeFormat = DateFormat('dd MMMM, HH:mm', Localizations.localeOf(context).toString());
  var dateType = ref.read(appConfigProvider).dateType;
  var startDate = dateType == DateType.local ?  eventSummary.startTime.toLocal() :  eventSummary.startTime.toUtc();

  return GestureDetector(
    onTap: () => context.push(AppRoutes.eventDetailScreen, extra: eventSummary,),
    child: Container(
      padding: const EdgeInsets.all(5),
      width: 180,
      decoration: BoxDecoration(
          border: Border.all(
              color: SftColors.lightGreen.withValues(alpha: 0.4),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          )
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
                Radius.circular(5)
            ),
            child: Hero(
              tag: eventSummary.id,
              child: CachedNetworkImage(
                imageUrl: eventSummary.poster,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          verticalSpace(5),
          Flexible(
            child: Text(eventSummary.name,
              style: titleStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text('${timeFormat.format(startDate)}${dateType.name.characters.first.toUpperCase()}', style: dateStyle,)
        ],
      ),
    ),
  );
}