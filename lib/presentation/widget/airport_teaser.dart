import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sim_flights_tracker/presentation/util/bottom_sheets.dart';

import '../../data/entity/_airport.dart';
import '../util/space_utils.dart';

class AirportTeaser extends StatelessWidget {
  final Airport airport;
  final WidgetRef ref;
  final bool controllerDetailsEnabled;
  const AirportTeaser({super.key, required this.airport, required this.ref, this.controllerDetailsEnabled = true});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => showAirportDetails(context, airport, ref, controllerDetailsEnabled),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(airport.name, style: theme.textTheme.titleSmall,
                    ),
                    verticalSpace(10),
                    Row(
                      children: [
                        Text(airport.identification, style: theme.textTheme.bodySmall,),
                        horizontalSpace(10),
                        Text(airport.type, style: theme.textTheme.bodySmall,),
                        horizontalSpace(10),
                        Text(airport.country.name, style: theme.textTheme.bodySmall,),
                      ],
                    )
                  ],
                ),
              ),
              const Icon(Icons.chevron_right,),
            ],
          ),
        ),
      ),
    );
  }
}
