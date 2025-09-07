import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:sim_flights_tracker/core/debouncer.dart';
import 'package:sim_flights_tracker/core/state/provider/providers.dart';
import 'package:sim_flights_tracker/core/theme/colors.dart';
import 'package:sim_flights_tracker/presentation/util/general_utils.dart';

import '../../core/config/i10n/generated/app_localizations.dart';
import '../util/space_utils.dart';
import '../widget/airport_teaser.dart';
import '../widget/banner_add_container.dart';
import '../widget/common_search_bar.dart';
import '../widget/custom_divider.dart';
import '../widget/error_widget.dart';

class AirportsScreen extends ConsumerWidget {
  AirportsScreen({super.key});

  final _bannerAd = createBannerAd();
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var shouldShowPromos = false;

    return Container(
      color: SftColors.primaryDark,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              CommonSearchBar(searchField: TextFormField(
                initialValue: '',
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.searchAirports,
                  suffixIcon: const Icon(LineIcons.search,),
                ),
                onChanged: (value) {
                  _debouncer.run(() => ref.read(airportsProvider.notifier).searchAirport(value.toUpperCase().trim()));
                },
              ), shouldPop: true,),
              Consumer(
                builder: (_, reference, __) => reference.watch(airportsProvider).when(
                  data: (data) => Expanded(
                    child: ListView.separated(
                      itemCount: data.matchingAirports.length,
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      separatorBuilder: (_, __) => verticalSpace(10),
                      itemBuilder: (_, index) => AirportTeaser(airport: data.matchingAirports[index], ref: reference, controllerDetailsEnabled: false,),
                    ),
                  ),
                  loading: () => Expanded(
                    child: Lottie.asset('assets/lottie/search_anim2.json',
                        width: 200,
                        frameRate: FrameRate.max
                    ),
                  ),
                  error: (err, st) => CustomErrorWidget(errorMessage: AppLocalizations.of(context)!.oops)
                ),
              ),
              if (shouldShowPromos) customDivider(hasBottomMargin: false, hasTopMargin: false),
              if (shouldShowPromos) bannerAdContainer(_bannerAd..load()),
            ],
          ),
        ),
      ),
    );
  }
}