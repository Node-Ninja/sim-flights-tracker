// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get network => 'Network';

  @override
  String get flights => 'Flights';

  @override
  String get controllers => 'Control';

  @override
  String get observers => 'Observers';

  @override
  String get home => 'Home';

  @override
  String get map => 'Map';

  @override
  String get menu => 'Menu';

  @override
  String get altitude => 'Altitude';

  @override
  String get speed => 'Speed';

  @override
  String get heading => 'Heading';

  @override
  String get totalDistance => 'Total Distance';

  @override
  String get distanceTravelled => 'Distance Travelled';

  @override
  String get distanceRemaining => 'Distance Remaining';

  @override
  String get timeToDestination => 'Time to Destination';

  @override
  String get etaLocal => 'ETA';

  @override
  String get etaZulu => 'ETA Zulu';

  @override
  String get country => 'Country';

  @override
  String get name => 'Name';

  @override
  String get callsign => 'Callsign';

  @override
  String get airlineDetails => 'Airline Details';

  @override
  String get flightDetails => 'Flight Information';

  @override
  String captain(Object name) {
    return 'Captain $name';
  }

  @override
  String get aircraft => 'Aircraft';

  @override
  String get company => 'Company';

  @override
  String get arrived => 'Arrived';

  @override
  String get enRoute => 'En Route';

  @override
  String get approaching => 'Approaching';

  @override
  String get circuits => 'Circuits';

  @override
  String get virtualAirline => 'Virtual Airline';

  @override
  String get flag => 'Flag';

  @override
  String get region => 'Region';

  @override
  String get clearance => 'Clearance';

  @override
  String get boarding => 'Boarding';

  @override
  String get departing => 'Departing';

  @override
  String get arrivingShortly => 'Arriving Shortly';

  @override
  String get unknown => 'Unknown';

  @override
  String get notAvailable => 'Not Available';

  @override
  String get noOFP => 'Flight plan not filed';

  @override
  String get waitingOFP => 'Waiting for flight plan';

  @override
  String get unknownAircraft => 'Unknown aircraft';

  @override
  String get noFlightDetails =>
      'Cannot load flight details. Please try again later.';

  @override
  String get flightDisconnected =>
      'The flight has disconnected from the network.';

  @override
  String get errorFlightLoad =>
      'Something went wrong getting flight details. Please view another flight or try again later. We apologize for any inconvenience.';

  @override
  String get airportSearch => 'Airport Search';

  @override
  String get vatsimEvents => 'Vatsim Events';

  @override
  String get settings => 'Settings';

  @override
  String get atcNetwork => 'ATC Network';

  @override
  String get language => 'Language';

  @override
  String get aboutApp =>
      'Sim Flights Tracker is an app that tracks aircraft that are live on the Vatsim and Ivao networks. This app uses publicly available data from Vatsim and from Ivao.';

  @override
  String get appDisclaimer =>
      'All third-party names, logos, and trademarks (including but not limited to airline brands) are the property of their respective owners. Their inclusion in this app is for informational and illustrative purposes only, and does not imply any affiliation with, sponsorship by, or endorsement from the respective trademark holders.\n\nThis app is not affiliated with, sponsored by, or endorsed by any airline or flight simulation network.';

  @override
  String get loaderText => 'Fetching details';

  @override
  String get searchATC => 'Search with area code or airport ICAO ID';

  @override
  String get noControllers =>
      'No controllers found matching your search query. Please try again.';

  @override
  String get searchAirports => 'Search with airport name or airport ICAO ID';

  @override
  String get airportsInfo =>
      'Search and find information about airports around the world';

  @override
  String get oops => 'Oops! Something went wrong. Please try again later.';

  @override
  String get noFlightsQuery =>
      'No flights found matching your search query. Please try again';

  @override
  String get searchWithFlightNumber => 'Search with flight number';

  @override
  String get onlineControllers => 'Online Controllers';

  @override
  String get identification => 'Identification';

  @override
  String get surface => 'Surface';

  @override
  String get hasLights => 'Has lights?';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get viewDetails => 'View details';

  @override
  String get elevation => 'Elevation';

  @override
  String get lostInternetConnection =>
      'Lost connection to the internet. Please reconnect.';

  @override
  String get hasNotStarted => 'Hasn\'t started';

  @override
  String get startingNow => 'Starting Now';

  @override
  String get inProgress => 'In Progress';

  @override
  String get endingNow => 'Ending Now';

  @override
  String get hasEnded => 'Has Ended';

  @override
  String get tapToExit => 'Tap back to exit';

  @override
  String get variable => 'Variable';

  @override
  String get noMetar => 'No metar information available.';

  @override
  String get windCalm => 'Wind calm';

  @override
  String get goBack => 'Go Back';

  @override
  String get noEvents => 'No Events Found';

  @override
  String get noEventsPlanned => 'There are no events planned for this day.';

  @override
  String get dateType => 'Use date/time';

  @override
  String get hourLetter => 'h';

  @override
  String get minuteShort => 'min';

  @override
  String get local => 'Local';

  @override
  String timeSelection(Object type) {
    return 'Times and dates are in $type time';
  }

  @override
  String get delivery => 'Delivery';

  @override
  String get ground => 'Ground';

  @override
  String get tower => 'Tower';

  @override
  String get approach => 'Approach';

  @override
  String get center => 'Center';

  @override
  String get atcFull => 'Air Traffic Controller';

  @override
  String get flyingNoOfp => 'Flying without a valid flight plan.';

  @override
  String get shareEvent => 'Share Event';

  @override
  String get partakingAirports => 'Partaking Airports';

  @override
  String get endTime => 'End Time';

  @override
  String get startTime => 'Start Time';

  @override
  String get organizer => 'Organizer';

  @override
  String get eventDetails => 'Event Details';

  @override
  String get eventReminderRemoved => 'Event reminder has been removed.';

  @override
  String get eventReminderSet => 'Reminder has been set for this event.';

  @override
  String get eventAdd => 'Add reminder';

  @override
  String get eventRemove => 'Remove reminder';

  @override
  String get minutes => 'minutes';

  @override
  String get hours => 'hours';

  @override
  String get watchAd => 'Watch Ad';

  @override
  String get flightsLog => 'VATSIM Profile';

  @override
  String get flightInProgress => 'Flight in progress';

  @override
  String get noFlightHistory =>
      'No history. Please check your Vatsim ID in the app settings';

  @override
  String get helipad => 'Helipad';

  @override
  String get runways => 'Runways';

  @override
  String get vatsimId => 'Vatsim ID';

  @override
  String get about => 'About';

  @override
  String get latestHundredFlights => 'VATSIM profile and flights';

  @override
  String get searchAirportInformation => 'Search airport information and metar';

  @override
  String get vatsimEventsDescription => 'Current and upcoming events on Vatsim';

  @override
  String get settingsDescription => 'Preferences and contributions';

  @override
  String get aboutAppDescription => 'Information about the app and developer';

  @override
  String get totalFlightCount => 'Total Flights';

  @override
  String get viewMore => 'View more';

  @override
  String get events => 'Events';

  @override
  String get supportApp =>
      'Love using the app? Help us keep improving by making a contribution below! Your support goes a long way. And while you\'re here, we\'d appreciate it if you could take a moment to rate us on Google Play or the App Store. Thank you!';

  @override
  String get donatePaypal => 'Buy me coffee';

  @override
  String get pilotHours => 'Pilot hours';

  @override
  String get atcHours => 'ATC hours';

  @override
  String get supHours => 'SUP hours';

  @override
  String get generalSettings => 'General Settings';

  @override
  String get vatsimSettings => 'Vatsim Setting';

  @override
  String get supportTheApp => 'Support the app';

  @override
  String get cruiseAltitude => 'Cruise Altitude';

  @override
  String get cruiseSpeed => 'Cruise Speed';

  @override
  String get navbarStyle => 'Navbar Style';

  @override
  String get loginWithVatsim => 'Login with your VATSIM account';

  @override
  String get loginWithVatsimLabel =>
      'View profile details, flight history, and more';

  @override
  String get authWithVatsim => 'Login with VATSIM';

  @override
  String get logout => 'Logout';

  @override
  String get configLoadFail =>
      'Could not load app configuration. Please restart the app.';

  @override
  String get screenNotFound => 'The screen you are looking for does not exist';
}
