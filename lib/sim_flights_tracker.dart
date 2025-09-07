import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sim_flights_tracker/core/config/i10n/fallback_localization.dart';
import 'package:sim_flights_tracker/core/config/i10n/tswana_intl.dart';
import 'package:sim_flights_tracker/core/constants/supported_language.dart';
import 'package:sim_flights_tracker/core/globals/globals.dart';
import 'package:sim_flights_tracker/core/state/provider/providers.dart';
import 'package:sim_flights_tracker/core/theme/colors.dart';
import 'package:sim_flights_tracker/core/theme/theme_constants.dart';
import 'package:sim_flights_tracker/presentation/util/general_utils.dart';

import 'core/config/i10n/generated/app_localizations.dart';
import 'core/config/router_config.dart';

class SimFlightsTracker extends ConsumerStatefulWidget {

  const SimFlightsTracker({super.key});

  @override
  ConsumerState<SimFlightsTracker> createState() => _SimFlightsTrackerState();
}

class _SimFlightsTrackerState extends ConsumerState<SimFlightsTracker> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    final configProviderNotifier = ref.read(appConfigProvider.notifier);
    final dataProviderNotifier = ref.read(liveDataProvider.notifier);
    final allEventsProvider = ref.read(eventsProvider.notifier);
    final adsProviderNotifier = ref.read(adsProvider.notifier);
    final notificationsProviderNotifier = ref.read(notificationsProvider.notifier);

    configProviderNotifier.boostrapAppConfiguration().then((hasLoaded) {
      if (hasLoaded) {
        dataProviderNotifier.refreshLiveData();
        allEventsProvider.loadAllEvents();
        adsProviderNotifier.refreshInterstitialAdvert();
        notificationsProviderNotifier.initLocalNotifications();

        if (ref.read(appConfigProvider).vatsimId.isNotEmpty && ref.read(appConfigProvider).vatsimAuthenticationId.isNotEmpty) {
          configProviderNotifier.completeAuthentication(ref.read(appConfigProvider).vatsimAuthenticationId);
        }

        _timer = Timer.periodic(const Duration(seconds: 20), (timer) {
          dataProviderNotifier.refreshLiveData();
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showSnackBarNotification(AppLocalizations.of(context)!.configLoadFail, isSticky: true);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Consumer(
      builder: (context, ref, child) {
        var currentLocale = ref.watch(appConfigProvider.select((state) => state.currentLocale));

        return MaterialApp.router(
          scaffoldMessengerKey: snackBarKey,
          routerConfig: AppRouter.router,
          title: 'Sim Flights Tracker',
          color: SftColors.primary,
          theme: darkTheme,
          themeMode: ThemeMode.dark,
          debugShowCheckedModeBanner: false,
          localizationsDelegates:  [
            ...AppLocalizations.localizationsDelegates,
            FallbackLocalizationDelegate(),
            TNMaterialLocalizations.delegate,
          ],
          supportedLocales: [
            ...SupportedLanguage.values.map((lang) => Locale(lang.name)),
          ],
          locale: currentLocale
        );
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}