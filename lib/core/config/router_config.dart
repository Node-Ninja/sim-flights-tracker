import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sim_flights_tracker/core/constants/app_routes.dart';
import 'package:sim_flights_tracker/core/observers/navigation_observer.dart';
import 'package:sim_flights_tracker/presentation/screen/about_screen.dart';
import 'package:sim_flights_tracker/presentation/screen/donate_success_screen.dart';
import 'package:sim_flights_tracker/presentation/screen/donation_screen.dart';
import 'package:sim_flights_tracker/presentation/screen/error/generic_error_screen.dart';
import 'package:sim_flights_tracker/presentation/screen/vatsim/flight_history_screen.dart';
import 'package:sim_flights_tracker/presentation/screen/vatsim/start_vatsim_auth_screen.dart';
import 'package:sim_flights_tracker/presentation/screen/vatsim/vatsim_profile_screen.dart';

import '../../data/entity/_flight_summary.dart';
import '../../data/entity/_sft_event_summary.dart';
import '../../presentation/screen/airports_screen.dart';
import '../../presentation/screen/controllers_screen.dart';
import '../../presentation/screen/error/not_found_screen.dart';
import '../../presentation/screen/events/event_details_screen.dart';
import '../../presentation/screen/events/events_home_screen.dart';
import '../../presentation/screen/flight_details.dart';
import '../../presentation/screen/flights_filter_screen.dart';
import '../../presentation/screen/landing_screen.dart';
import '../../presentation/screen/map_screen.dart';
import '../../presentation/screen/menu_screen.dart';
import '../../presentation/screen/settings_screen.dart';
import '../../presentation/util/dialog_page.dart';
import '../../presentation/widget/scaffold_with_navbar.dart';

class AppRouter {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();
  static final shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    initialLocation: AppRoutes.homeScreen,
    navigatorKey: rootNavigatorKey,
    observers: [
      NavigationObserver(),
    ],
    errorBuilder: (_, __) => const NotFoundScreen(message: '',),
    routes: <RouteBase>[
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        observers: [
          NavigationObserver()
        ],
        builder: (context, state, child) => ScaffoldWithNavbar(child: child),
        routes: <RouteBase>[
          GoRoute(
            name: AppRoutes.homeScreenNamed,
            path: AppRoutes.homeScreen,
            builder: (_, __) => LandingScreen(),
          ),
          GoRoute(
            name: AppRoutes.controllersScreenNamed,
            path: AppRoutes.controllersScreen,
            builder: (_, __) => ControllersScreen()
          ),
          GoRoute(
            name: AppRoutes.flightsScreenNamed,
            path: AppRoutes.flightsScreen,
            builder: (_, __) => FlightsFilterScreen(),
            routes: [
              GoRoute(
                  path: AppRoutes.flightDetailsScreen,
                  builder: (_, state) {
                    final String callsign = state.pathParameters['callsign']!;
                    return FlightDetails(callsign: callsign, flightPlan: state.extra as FlightPlanSummary?,);
                  }
              ),
            ]
          ),
          GoRoute(
            name: AppRoutes.menuScreenNamed,
            path: AppRoutes.menuScreen,
            builder: (_, __) => MenuScreen(),
          ),
          GoRoute(
            name: AppRoutes.mapScreenNamed,
            path: AppRoutes.mapScreen,
            builder: (_, __) => MapScreen(),
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        name: AppRoutes.settingsScreenNamed,
        path: AppRoutes.settingsScreen,
        builder: (_, __) => SettingsScreen(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        name: AppRoutes.airportsScreenNamed,
        path: AppRoutes.airportsScreen,
        builder: (_, __) => AirportsScreen(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        name: AppRoutes.eventsHomeScreenNamed,
        path: AppRoutes.eventsHomeScreen,
        builder: (ctx, __) {
          //  reset selected events date;
          return EventsHomeScreen();
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        name: AppRoutes.eventDetailScreenNamed,
        path: AppRoutes.eventDetailScreen,
        builder: (_, state) => EventDetailsScreen(eventSummary: state.extra as SftEventSummary),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        name: AppRoutes.tabletSettingsScreenNamed,
        path: AppRoutes.tabletSettingsScreen,
        pageBuilder: (_, __) => DialogPage(
          builder: (_) => SettingsScreen()
        ),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        name: AppRoutes.aboutScreenNamed,
        path: AppRoutes.aboutScreen,
        builder: (_, __) => const AboutScreen(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        name: AppRoutes.vatsimFlightHistoryScreenNamed,
        path: AppRoutes.vatsimFlightHistoryScreen,
        builder: (_, __) => const FlightHistoryScreen(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        name: AppRoutes.donationScreenNamed,
        path: AppRoutes.donationScreen,
        builder: (_, __) => const DonationScreen(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        name: AppRoutes.donationScreenSuccessNamed,
        path: AppRoutes.donationSuccessScreen,
        builder: (_, __) => const DonateSuccessScreen(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        name: AppRoutes.vatsimProfileScreenNamed,
        path: AppRoutes.vatsimProfileScreen,
        builder: (_, __) => const VatsimProfileScreen(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        name: AppRoutes.vatsimAuthStartScreenNamed,
        path: AppRoutes.vatsimAuthStartScreen,
        builder: (_, state) => StartVatsimAuthScreen(authUri: state.extra as Uri,),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        name: AppRoutes.errorScreenNamed,
        path: AppRoutes.errorScreen,
        builder: (_, state) => GenericErrorScreen(message: state.extra as String),
      ),
    ],
  );

  static GoRouter get router => _router;
}