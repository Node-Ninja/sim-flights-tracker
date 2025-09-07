class AppRoutes {
  static const root = '/';
  static const homeScreen = '/home';
  static const flightsScreen = '/flights';
  static const controllersScreen = '/controllers';
  static const airportsScreen = '/airports';
  static const settingsScreen = '/settings';
  static const mapScreen = '/map';
  static const menuScreen = '/menu';
  static const eventsHomeScreen = '/events';
  static const eventDetailScreen = '/event/details';
  static const eventsFilterScreen = '/events/filter';
  static const eventNotificationsScreen = '/events/notifications';
  static const vatsimProfileScreen = '/vatsim/profile';

  static const vatsimFlightDetailsScreen = 'vatsim/:id';
  static const ivaoFlightDetailsScreen = 'ivao/:id';
  static const airportDetailsScreen = 'details';

  static const homeScreenNamed = 'homeScreen';
  static const controllersScreenNamed = 'controllersScreen';
  static const flightsScreenNamed = 'flightsScreen';
  static const airportsScreenNamed = 'airportsScreen';
  static const settingsScreenNamed = 'settingsScreen';
  static const airportDetailsScreenNamed = 'airportDetailsScreen';
  static const mapScreenNamed = 'mapScreen';
  static const menuScreenNamed = 'menuScreen';
  static const eventsHomeScreenNamed = 'eventsHomeScreen';
  static const eventDetailScreenNamed = 'eventDetailScreen';
  static const eventsFilterScreenNames = 'eventsFilterScreen';
  static const eventNotificationsScreenNamed = 'eventNotificationsScreen';
  static const vatsimProfileScreenNamed = 'vatsimProfileScreen';

  static const flightDetailsScreen = 'details/:callsign';

  static const tabletSettingsScreenNamed = 'TabletSettingsScreen';
  static const tabletSettingsScreen = '/tablet/settings';

  static const aboutScreen = '/about';
  static const aboutScreenNamed = 'AboutScreen';

  static const vatsimFlightHistoryScreen = '/vatsim/flight/history';
  static const vatsimFlightHistoryScreenNamed = 'vatsimFlightHistoryScreen';

  static const donationScreen = '/donation';
  static const donationScreenNamed = 'DonationScreen';
  static const donationScreenSuccessNamed = 'DonationSuccessScreen';
  static const donationSuccessScreen = '/donation/success';

  static const vatsimAuthStartScreen = '/vatsim/auth/start';
  static const vatsimAuthStartScreenNamed = 'VatsimAuthStartScreen';

  static const errorScreen = '/error';
  static const errorScreenNamed = 'ErrorScreenNamed';
}