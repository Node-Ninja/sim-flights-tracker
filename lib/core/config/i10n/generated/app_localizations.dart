import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_af.dart';
import 'app_localizations_en.dart';
import 'app_localizations_id.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tn.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('af'),
    Locale('en'),
    Locale('id'),
    Locale('ru'),
    Locale('tn'),
  ];

  /// Sim Network. Currently this app supports Vatsim and Ivao networks.
  ///
  /// In en, this message translates to:
  /// **'Network'**
  String get network;

  /// Flights currently live on the network.
  ///
  /// In en, this message translates to:
  /// **'Flights'**
  String get flights;

  /// Air traffic controllers
  ///
  /// In en, this message translates to:
  /// **'Control'**
  String get controllers;

  /// People connected to the network, not as pilots nor controllers or supervisors.
  ///
  /// In en, this message translates to:
  /// **'Observers'**
  String get observers;

  /// Home page of the app
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Map page of the app
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get map;

  /// Menu of the app
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// Altitude or height above ground level or high above sea level.
  ///
  /// In en, this message translates to:
  /// **'Altitude'**
  String get altitude;

  /// Speed
  ///
  /// In en, this message translates to:
  /// **'Speed'**
  String get speed;

  /// Compass heading
  ///
  /// In en, this message translates to:
  /// **'Heading'**
  String get heading;

  /// Total distance
  ///
  /// In en, this message translates to:
  /// **'Total Distance'**
  String get totalDistance;

  /// Distance travelled
  ///
  /// In en, this message translates to:
  /// **'Distance Travelled'**
  String get distanceTravelled;

  /// Distance remaining to destination
  ///
  /// In en, this message translates to:
  /// **'Distance Remaining'**
  String get distanceRemaining;

  /// Time remaining to destination
  ///
  /// In en, this message translates to:
  /// **'Time to Destination'**
  String get timeToDestination;

  /// Estimated time of arrival in local time
  ///
  /// In en, this message translates to:
  /// **'ETA'**
  String get etaLocal;

  /// Estimated time of arrival in Zulu time
  ///
  /// In en, this message translates to:
  /// **'ETA Zulu'**
  String get etaZulu;

  /// Country
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// Name of the pilot or controller
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// Callsign of the pilot or controller
  ///
  /// In en, this message translates to:
  /// **'Callsign'**
  String get callsign;

  /// Details about the airline
  ///
  /// In en, this message translates to:
  /// **'Airline Details'**
  String get airlineDetails;

  /// Details about the flight
  ///
  /// In en, this message translates to:
  /// **'Flight Information'**
  String get flightDetails;

  /// Captain of the flight
  ///
  /// In en, this message translates to:
  /// **'Captain {name}'**
  String captain(Object name);

  /// Aircraft / airplane
  ///
  /// In en, this message translates to:
  /// **'Aircraft'**
  String get aircraft;

  /// Company
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get company;

  /// Flight has arrived at destination
  ///
  /// In en, this message translates to:
  /// **'Arrived'**
  String get arrived;

  /// Flight is en route to destination
  ///
  /// In en, this message translates to:
  /// **'En Route'**
  String get enRoute;

  /// Flight is approaching destination
  ///
  /// In en, this message translates to:
  /// **'Approaching'**
  String get approaching;

  /// When an aircraft is flying circuits, it means it is flying a pattern around an airport, usually for training purposes.
  ///
  /// In en, this message translates to:
  /// **'Circuits'**
  String get circuits;

  /// Virtual airline is a simulation of a real airline, where pilots can fly flights as if they were part of that airline.
  ///
  /// In en, this message translates to:
  /// **'Virtual Airline'**
  String get virtualAirline;

  /// Flag of a country
  ///
  /// In en, this message translates to:
  /// **'Flag'**
  String get flag;

  /// Region of the world
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get region;

  /// Clearance is the permission given by air traffic control to an aircraft to proceed with a flight.
  ///
  /// In en, this message translates to:
  /// **'Clearance'**
  String get clearance;

  /// Boarding is the process of passengers getting onto an aircraft before a flight.
  ///
  /// In en, this message translates to:
  /// **'Boarding'**
  String get boarding;

  /// Flight is departing from an airport
  ///
  /// In en, this message translates to:
  /// **'Departing'**
  String get departing;

  /// Flight is arriving shortly at destination
  ///
  /// In en, this message translates to:
  /// **'Arriving Shortly'**
  String get arrivingShortly;

  /// Unknown
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// Not available
  ///
  /// In en, this message translates to:
  /// **'Not Available'**
  String get notAvailable;

  /// OFP = Operational Flight Plan. This means that the flight plan has not been filed or is not available.
  ///
  /// In en, this message translates to:
  /// **'Flight plan not filed'**
  String get noOFP;

  /// Waiting for the flight plan to be filed
  ///
  /// In en, this message translates to:
  /// **'Waiting for flight plan'**
  String get waitingOFP;

  /// Unknown aircraft
  ///
  /// In en, this message translates to:
  /// **'Unknown aircraft'**
  String get unknownAircraft;

  /// Cannot load flight details. Please try again later.
  ///
  /// In en, this message translates to:
  /// **'Cannot load flight details. Please try again later.'**
  String get noFlightDetails;

  /// The flight has disconnected from the network.
  ///
  /// In en, this message translates to:
  /// **'The flight has disconnected from the network.'**
  String get flightDisconnected;

  /// Can't load flight details. Please try again later.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong getting flight details. Please view another flight or try again later. We apologize for any inconvenience.'**
  String get errorFlightLoad;

  /// Search for an airport
  ///
  /// In en, this message translates to:
  /// **'Airport Search'**
  String get airportSearch;

  /// Events on the Vatsim network
  ///
  /// In en, this message translates to:
  /// **'Vatsim Events'**
  String get vatsimEvents;

  /// Settings of the app
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Air Traffic Control network same as 'network'
  ///
  /// In en, this message translates to:
  /// **'ATC Network'**
  String get atcNetwork;

  /// Language of the app
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Information about the app
  ///
  /// In en, this message translates to:
  /// **'Sim Flights Tracker is an app that tracks aircraft that are live on the Vatsim and Ivao networks. This app uses publicly available data from Vatsim and from Ivao.'**
  String get aboutApp;

  /// Disclaimer about the app and its usage
  ///
  /// In en, this message translates to:
  /// **'All third-party names, logos, and trademarks (including but not limited to airline brands) are the property of their respective owners. Their inclusion in this app is for informational and illustrative purposes only, and does not imply any affiliation with, sponsorship by, or endorsement from the respective trademark holders.\n\nThis app is not affiliated with, sponsored by, or endorsed by any airline or flight simulation network.'**
  String get appDisclaimer;

  /// Text shown while loading data
  ///
  /// In en, this message translates to:
  /// **'Fetching details'**
  String get loaderText;

  /// Search for air traffic controllers using area code or airport ICAO ID
  ///
  /// In en, this message translates to:
  /// **'Search with area code or airport ICAO ID'**
  String get searchATC;

  /// No controllers found.
  ///
  /// In en, this message translates to:
  /// **'No controllers found matching your search query. Please try again.'**
  String get noControllers;

  /// Search for airports.
  ///
  /// In en, this message translates to:
  /// **'Search with airport name or airport ICAO ID'**
  String get searchAirports;

  /// Search and find information about airports around the world
  ///
  /// In en, this message translates to:
  /// **'Search and find information about airports around the world'**
  String get airportsInfo;

  /// Oops! Something went wrong. Please try again later.
  ///
  /// In en, this message translates to:
  /// **'Oops! Something went wrong. Please try again later.'**
  String get oops;

  /// No flights found matching your search query. Please try again
  ///
  /// In en, this message translates to:
  /// **'No flights found matching your search query. Please try again'**
  String get noFlightsQuery;

  /// Search for flights using flight number
  ///
  /// In en, this message translates to:
  /// **'Search with flight number'**
  String get searchWithFlightNumber;

  /// Online air traffic controllers
  ///
  /// In en, this message translates to:
  /// **'Online Controllers'**
  String get onlineControllers;

  /// Identification of a airport or helipad
  ///
  /// In en, this message translates to:
  /// **'Identification'**
  String get identification;

  /// Surface of the runway or helipad
  ///
  /// In en, this message translates to:
  /// **'Surface'**
  String get surface;

  /// Whether the runway has lights or not
  ///
  /// In en, this message translates to:
  /// **'Has lights?'**
  String get hasLights;

  /// Yes
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// View more details for selected resource
  ///
  /// In en, this message translates to:
  /// **'View details'**
  String get viewDetails;

  /// Elevation or height above sea level
  ///
  /// In en, this message translates to:
  /// **'Elevation'**
  String get elevation;

  /// Lost connection to the internet. Please reconnect.
  ///
  /// In en, this message translates to:
  /// **'Lost connection to the internet. Please reconnect.'**
  String get lostInternetConnection;

  /// Flight or event has not started yet
  ///
  /// In en, this message translates to:
  /// **'Hasn\'t started'**
  String get hasNotStarted;

  /// Flight or event is starting now
  ///
  /// In en, this message translates to:
  /// **'Starting Now'**
  String get startingNow;

  /// Flight or event is currently in progress
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get inProgress;

  /// Flight or event is ending now
  ///
  /// In en, this message translates to:
  /// **'Ending Now'**
  String get endingNow;

  /// Flight or event has ended
  ///
  /// In en, this message translates to:
  /// **'Has Ended'**
  String get hasEnded;

  /// Tap back to exit the current screen
  ///
  /// In en, this message translates to:
  /// **'Tap back to exit'**
  String get tapToExit;

  /// Variable weather conditions
  ///
  /// In en, this message translates to:
  /// **'Variable'**
  String get variable;

  /// No METAR information available
  ///
  /// In en, this message translates to:
  /// **'No metar information available.'**
  String get noMetar;

  /// Wind is calm
  ///
  /// In en, this message translates to:
  /// **'Wind calm'**
  String get windCalm;

  /// Go back to the previous screen
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get goBack;

  /// No events found
  ///
  /// In en, this message translates to:
  /// **'No Events Found'**
  String get noEvents;

  /// There are no events planned for this day.
  ///
  /// In en, this message translates to:
  /// **'There are no events planned for this day.'**
  String get noEventsPlanned;

  /// Use date/time format
  ///
  /// In en, this message translates to:
  /// **'Use date/time'**
  String get dateType;

  /// Letter used to represent hours in time
  ///
  /// In en, this message translates to:
  /// **'h'**
  String get hourLetter;

  /// Short form of minutes
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get minuteShort;

  /// Local time
  ///
  /// In en, this message translates to:
  /// **'Local'**
  String get local;

  /// Times and dates are in local time or Zulu time
  ///
  /// In en, this message translates to:
  /// **'Times and dates are in {type} time'**
  String timeSelection(Object type);

  /// Delivery is a type of air traffic control service that provides coverage for aircraft on the ground at an airport.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get delivery;

  /// Ground is a type of air traffic control service that provides coverage for aircraft on the ground at an airport.
  ///
  /// In en, this message translates to:
  /// **'Ground'**
  String get ground;

  /// Tower is a type of air traffic control service that provides coverage for aircraft on the ground and in the airspace around an airport.
  ///
  /// In en, this message translates to:
  /// **'Tower'**
  String get tower;

  /// Approach is a type of air traffic control service that provides coverage for aircraft approaching an airport.
  ///
  /// In en, this message translates to:
  /// **'Approach'**
  String get approach;

  /// Center is a type of air traffic control service that provides coverage over a large area.
  ///
  /// In en, this message translates to:
  /// **'Center'**
  String get center;

  /// Full name of the air traffic controller
  ///
  /// In en, this message translates to:
  /// **'Air Traffic Controller'**
  String get atcFull;

  /// Flying without a valid flight plan.
  ///
  /// In en, this message translates to:
  /// **'Flying without a valid flight plan.'**
  String get flyingNoOfp;

  /// Share event
  ///
  /// In en, this message translates to:
  /// **'Share Event'**
  String get shareEvent;

  /// Airports that are partaking in the event
  ///
  /// In en, this message translates to:
  /// **'Partaking Airports'**
  String get partakingAirports;

  /// End time of the event
  ///
  /// In en, this message translates to:
  /// **'End Time'**
  String get endTime;

  /// Start time of the event
  ///
  /// In en, this message translates to:
  /// **'Start Time'**
  String get startTime;

  /// Organizer of the event
  ///
  /// In en, this message translates to:
  /// **'Organizer'**
  String get organizer;

  /// Details about the event
  ///
  /// In en, this message translates to:
  /// **'Event Details'**
  String get eventDetails;

  /// Event reminder has been removed.
  ///
  /// In en, this message translates to:
  /// **'Event reminder has been removed.'**
  String get eventReminderRemoved;

  /// Reminder has been set for this event
  ///
  /// In en, this message translates to:
  /// **'Reminder has been set for this event.'**
  String get eventReminderSet;

  /// Add reminder for an event
  ///
  /// In en, this message translates to:
  /// **'Add reminder'**
  String get eventAdd;

  /// Remove reminder for an event
  ///
  /// In en, this message translates to:
  /// **'Remove reminder'**
  String get eventRemove;

  /// Minutes
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get minutes;

  /// Hours
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get hours;

  /// Watch an ad to support the app
  ///
  /// In en, this message translates to:
  /// **'Watch Ad'**
  String get watchAd;

  /// Flights log
  ///
  /// In en, this message translates to:
  /// **'VATSIM Profile'**
  String get flightsLog;

  /// Flight in progress
  ///
  /// In en, this message translates to:
  /// **'Flight in progress'**
  String get flightInProgress;

  /// No flight history available. Please check your Vatsim ID in the app settings.
  ///
  /// In en, this message translates to:
  /// **'No history. Please check your Vatsim ID in the app settings'**
  String get noFlightHistory;

  /// Helipad is a landing area for helicopters
  ///
  /// In en, this message translates to:
  /// **'Helipad'**
  String get helipad;

  /// Runways at the airport
  ///
  /// In en, this message translates to:
  /// **'Runways'**
  String get runways;

  /// Vatsim ID of the pilot or controller
  ///
  /// In en, this message translates to:
  /// **'Vatsim ID'**
  String get vatsimId;

  /// About the app
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Your latest 100 flights
  ///
  /// In en, this message translates to:
  /// **'VATSIM profile and flights'**
  String get latestHundredFlights;

  /// Search airport information and metar
  ///
  /// In en, this message translates to:
  /// **'Search airport information and metar'**
  String get searchAirportInformation;

  /// Description of Vatsim events
  ///
  /// In en, this message translates to:
  /// **'Current and upcoming events on Vatsim'**
  String get vatsimEventsDescription;

  /// Preferences and contributions
  ///
  /// In en, this message translates to:
  /// **'Preferences and contributions'**
  String get settingsDescription;

  /// Information about the app and developer
  ///
  /// In en, this message translates to:
  /// **'Information about the app and developer'**
  String get aboutAppDescription;

  /// Total number of flights
  ///
  /// In en, this message translates to:
  /// **'Total Flights'**
  String get totalFlightCount;

  /// View more flights or events
  ///
  /// In en, this message translates to:
  /// **'View more'**
  String get viewMore;

  /// Events
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get events;

  /// Support the app by donating or contributing
  ///
  /// In en, this message translates to:
  /// **'Love using the app? Help us keep improving by making a contribution below! Your support goes a long way. And while you\'re here, we\'d appreciate it if you could take a moment to rate us on Google Play or the App Store. Thank you!'**
  String get supportApp;

  /// Donate
  ///
  /// In en, this message translates to:
  /// **'Buy me coffee'**
  String get donatePaypal;

  /// Hours connected as pilot
  ///
  /// In en, this message translates to:
  /// **'Pilot hours'**
  String get pilotHours;

  /// Hours connected as air traffic controller
  ///
  /// In en, this message translates to:
  /// **'ATC hours'**
  String get atcHours;

  /// Hours connectd as supervisor
  ///
  /// In en, this message translates to:
  /// **'SUP hours'**
  String get supHours;

  /// General Settings
  ///
  /// In en, this message translates to:
  /// **'General Settings'**
  String get generalSettings;

  /// Vatsim Settings
  ///
  /// In en, this message translates to:
  /// **'Vatsim Setting'**
  String get vatsimSettings;

  /// Support the app
  ///
  /// In en, this message translates to:
  /// **'Support the app'**
  String get supportTheApp;

  /// Cruise altitude of the aircraft
  ///
  /// In en, this message translates to:
  /// **'Cruise Altitude'**
  String get cruiseAltitude;

  /// Cruise speed of the aircraft
  ///
  /// In en, this message translates to:
  /// **'Cruise Speed'**
  String get cruiseSpeed;

  /// Style of the bottom navigation bar
  ///
  /// In en, this message translates to:
  /// **'Navbar Style'**
  String get navbarStyle;

  /// No description provided for @loginWithVatsim.
  ///
  /// In en, this message translates to:
  /// **'Login with your VATSIM account'**
  String get loginWithVatsim;

  /// No description provided for @loginWithVatsimLabel.
  ///
  /// In en, this message translates to:
  /// **'View profile details, flight history, and more'**
  String get loginWithVatsimLabel;

  /// No description provided for @authWithVatsim.
  ///
  /// In en, this message translates to:
  /// **'Login with VATSIM'**
  String get authWithVatsim;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @configLoadFail.
  ///
  /// In en, this message translates to:
  /// **'Could not load app configuration. Please restart the app.'**
  String get configLoadFail;

  /// No description provided for @screenNotFound.
  ///
  /// In en, this message translates to:
  /// **'The screen you are looking for does not exist'**
  String get screenNotFound;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['af', 'en', 'id', 'ru', 'tn'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'af':
      return AppLocalizationsAf();
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
    case 'ru':
      return AppLocalizationsRu();
    case 'tn':
      return AppLocalizationsTn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
