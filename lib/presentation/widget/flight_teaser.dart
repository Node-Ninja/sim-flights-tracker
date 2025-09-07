import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';

import '../../core/config/i10n/generated/app_localizations.dart';
import '../../core/constants/sim_network.dart';
import '../../core/theme/colors.dart';
import '../../data/entity/_flight_summary.dart';
import '../util/space_utils.dart';

class FlightTeaser extends StatelessWidget {
  final dynamic flight;
  final SimNetwork simNetwork;
  final bool showDetailsLabel;
  final bool hasBorder;
  final bool isInTabletView;
  final bool shouldPopBeforeNavigate;
  final bool shouldShowCloseIcon;
  final PersistentBottomSheetController? bottomSheetController;

  const FlightTeaser({
    super.key,
    required this.flight,
    required this.simNetwork,
    this.showDetailsLabel = false,
    this.hasBorder = true,
    this.isInTabletView = false,
    this.shouldPopBeforeNavigate = false,
    this.shouldShowCloseIcon = false,
    this.bottomSheetController,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    var showLogos = true;

    FlightSummary flightSummary = flight;

    return GestureDetector(
      onTap: () {
        if (shouldPopBeforeNavigate) {
          if (bottomSheetController != null) {
            bottomSheetController!.close();
          } else {
            context.pop();
          }
        }

        context.push('/flights/details/${flightSummary.callsign}', extra: flightSummary.flightPlan);

      },
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        shape: (!hasBorder) ?  const RoundedRectangleBorder(
          side: BorderSide.none
        ) : null,
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
                  imageUrl: 'https://flightaware.com/images/airline_logos/90p/${(flightSummary.callsign.length >= 3) ? flightSummary.callsign.substring(0,3) : 'aaa' }.png',
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
              const SizedBox(width: 20,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(flightSummary.callsign, style: theme.textTheme.titleMedium,),
                    Text(
                      (flightSummary.flightPlan == null || flightSummary.flightPlan?.arrival == '' || flightSummary.flightPlan?.departure == '')
                          ? AppLocalizations.of(context)!.noOFP
                          : '${flightSummary.flightPlan?.departure} - ${flightSummary.flightPlan?.arrival}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  if (showDetailsLabel) Text(AppLocalizations.of(context)!.viewDetails),
                  horizontalSpace(5),
                  const Icon(
                    Icons.chevron_right,
                  ),
                  if (shouldShowCloseIcon) horizontalSpace(10),
                  if (shouldShowCloseIcon) SizedBox(width: 1,height: 30, child: Container( color: SftColors.lightGreen.withValues(alpha: 0.2),),),
                  if (shouldShowCloseIcon) horizontalSpace(20),
                  if (shouldShowCloseIcon) GestureDetector(
                    onTap: () {
                      if (bottomSheetController != null) {
                       bottomSheetController!.close();
                      }
                    },
                    child: const Icon(LineIcons.times,),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
