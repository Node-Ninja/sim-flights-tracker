import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sim_flights_tracker/core/state/provider/providers.dart';
import 'package:sim_flights_tracker/core/theme/colors.dart';
import 'package:sim_flights_tracker/core/theme/spacing.dart';
import 'package:sim_flights_tracker/core/utils.dart';

import '../../core/config/i10n/generated/app_localizations.dart';
import '../util/space_utils.dart';
import '../widget/custom_divider.dart';
import '../widget/navigation/custom_appbar.dart';

class AboutScreen extends ConsumerWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final String appVersion = ref.read(appConfigProvider).appVersion;
    final String appBuildNumber = ref.read(appConfigProvider).buildNumber;

    return Scaffold(
      appBar: const CustomAppBar(title: Text('Sim Flights Tracker'),),
      body: Column(
        children: [
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600),
              child: ListView(
                children: [
                  verticalSpace(20),
                  const Image(
                    image: AssetImage('assets/sft_transparent.png'),
                    width: 200,
                    height: 200,
                  ),
                  verticalSpace(20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: Spacing.standardPadding, vertical: Spacing.halfPadding),
                    child: Column(
                      children: <Widget> [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image(
                              image: AssetImage('assets/images/vatsim/VATSIM_Logo_White_500px.png',),
                              width: 130,
                            ),
                            Image(
                              image: AssetImage('assets/images/ivao_white.png',),
                              width: 130,
                            ),
                          ],
                        ),
                        verticalSpace(20),
                        Text(AppLocalizations.of(context)!.aboutApp,
                          style: theme.textTheme.bodySmall,
                          textAlign: TextAlign.justify,
                        ),
                        verticalSpace(20),
                        Text(AppLocalizations.of(context)!.appDisclaimer,
                          style: theme.textTheme.bodySmall,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          customDivider(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: Spacing.standardPadding,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => openBrowser('https://www.simflightstracker.com/privacy.html'),
                  child: Text('Privacy policy', style: TextStyle(color: SftColors.lightGreen),),
                ),
                horizontalSpace(Spacing.standardMargin),
                GestureDetector(
                  onTap: () => openBrowser('https://vatsim.net/'),
                  child: Text('VATSIM', style: TextStyle(color: SftColors.lightGreen),),
                ),
                horizontalSpace(Spacing.standardMargin),
                GestureDetector(
                  onTap: () => openBrowser('https://www.ivao.aero/'),
                  child: Text('IVAO', style: TextStyle(color: SftColors.lightGreen),),
                ),
                horizontalSpace(Spacing.standardMargin),
                GestureDetector(
                  onTap: () => openBrowser('https://github.com/Node-Ninja/sim-flights-tracker'),
                  child: Text('SFT Open Code', style: TextStyle(color: SftColors.lightGreen),),
                ),
              ],
            ),
          ),
          customDivider(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Version: $appVersion',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                'Build: $appBuildNumber-${Platform.operatingSystem}',
                style: const TextStyle(color: Colors.white38),
              ),
              verticalSpace(10),
            ],
          ),
        ],
      ),
    );
  }
}
