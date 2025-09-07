// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Afrikaans (`af`).
class AppLocalizationsAf extends AppLocalizations {
  AppLocalizationsAf([String locale = 'af']) : super(locale);

  @override
  String get network => 'Netwerk';

  @override
  String get flights => 'Vlugte';

  @override
  String get controllers => 'Controllers';

  @override
  String get observers => 'Observers';

  @override
  String get home => 'Tuis';

  @override
  String get map => 'Kaart';

  @override
  String get menu => 'Menu';

  @override
  String get altitude => 'Hoogte';

  @override
  String get speed => 'Spoed';

  @override
  String get heading => 'Heading';

  @override
  String get totalDistance => 'Totale Afstand';

  @override
  String get distanceTravelled => 'Aftsand reeds afgelê';

  @override
  String get distanceRemaining => 'Afstand oor';

  @override
  String get timeToDestination => 'Tyd tot by die bestemming';

  @override
  String get etaLocal => 'ETA';

  @override
  String get etaZulu => 'ETA Zulu';

  @override
  String get country => 'Land';

  @override
  String get name => 'Naam';

  @override
  String get callsign => 'Roepsein';

  @override
  String get airlineDetails => 'Lugredery se besonderhede';

  @override
  String get flightDetails => 'Inligting oor die vlug';

  @override
  String captain(Object name) {
    return 'Kaptein $name';
  }

  @override
  String get aircraft => 'Vliegtuig';

  @override
  String get company => 'Maatskappy';

  @override
  String get arrived => 'Gearriveer';

  @override
  String get enRoute => 'Oppad';

  @override
  String get approaching => 'Nader';

  @override
  String get circuits => 'Sirkels';

  @override
  String get virtualAirline => 'Virtuele Lugredery';

  @override
  String get flag => 'Vlag';

  @override
  String get region => 'Area';

  @override
  String get clearance => 'Opruiming';

  @override
  String get boarding => 'Instap';

  @override
  String get departing => 'Vertrek';

  @override
  String get arrivingShortly => 'Gaan binnekort arriveer';

  @override
  String get unknown => 'Onbekend';

  @override
  String get notAvailable => 'Nie beskikbaar nie';

  @override
  String get noOFP => 'Vlugplan nie geliasseer nie';

  @override
  String get waitingOFP => 'Wag vir vlugplan';

  @override
  String get unknownAircraft => 'Onbekende Vliegtuig';

  @override
  String get noFlightDetails =>
      'Kan nie vlugbesonderhede laai nie. Probeer asseblief weer later.';

  @override
  String get flightDisconnected => 'Die vlug het van die netwerk ontkoppel.';

  @override
  String get errorFlightLoad =>
      'Iets het verkeerd geloop om vlugbesonderhede te kry. Bekyk asseblief \'n ander vlug of probeer later weer. Ons vra om verskoning vir enige ongerief.';

  @override
  String get airportSearch => 'Soek ‘n lughawe';

  @override
  String get vatsimEvents => 'Vatsim gebeure';

  @override
  String get settings => 'Instellings';

  @override
  String get atcNetwork => 'ATC Netwerk';

  @override
  String get language => 'Taal';

  @override
  String get aboutApp =>
      'Sim Flights Tracker is ‘n toep wat vliegtue wat lewendig is op óf die Vatsim óf IVAO netwerk opspoor. Die toep gebruik inligting wat publiek beskikbaar is van Vatsim en van IVAO.';

  @override
  String get appDisclaimer =>
      'Alle derdeparty-produkte, maatskappyname en logo\'s is handelsmerke™ of geregistreerde® handelsmerke en bly die eiendom van hul onderskeie houers. Die gebruik daarvan impliseer geen affiliasie met of onderskrywing deur hulle nie.';

  @override
  String get loaderText => 'Haal tans besonderhede';

  @override
  String get searchATC =>
      'Soek met ‘n area kode or met ‘n lughawe se ICAO kode';

  @override
  String get noControllers =>
      'Geen beheerders gevind wat by jou soeknavraag pas nie. Probeer asseblief weer.';

  @override
  String get searchAirports =>
      'Soek met ‘n lughawe se naam of met ‘n lughawe se ICAO kode.';

  @override
  String get airportsInfo =>
      'Soek en vind inligting oor lughawens regoor die wêreld';

  @override
  String get oops =>
      'Agge nee! Iets het verkeerd gegaan. Probeer asseblief later weer.';

  @override
  String get noFlightsQuery =>
      'Geen vlugte gevind wat by jou soektog pas nie. Probeer asseblief weer';

  @override
  String get searchWithFlightNumber => 'Soek met ‘n vlug nommer';

  @override
  String get onlineControllers => 'Aanlyn lugverkeerbeheerder';

  @override
  String get identification => 'Identifikasie';

  @override
  String get surface => 'Oppervlakte';

  @override
  String get hasLights => 'Het ligte?';

  @override
  String get yes => 'Ja';

  @override
  String get no => 'Nee';

  @override
  String get viewDetails => 'Sien besonderhede';

  @override
  String get elevation => 'Hoogte';

  @override
  String get lostInternetConnection =>
      'Het verbinding met die internet verloor. Herkoppel asseblief.';

  @override
  String get hasNotStarted => 'Het nie begin nie';

  @override
  String get startingNow => 'Begin nou';

  @override
  String get inProgress => 'Aan die gang';

  @override
  String get endingNow => 'Eindig nou';

  @override
  String get hasEnded => 'Het geëindig';

  @override
  String get tapToExit => 'Tik terug om uit te gaan';

  @override
  String get variable => 'Veranderlik';

  @override
  String get noMetar => 'Geen METAR informasie is beskikbaar nie';

  @override
  String get windCalm => 'Wind is kalm';

  @override
  String get goBack => 'Gaan Terug';

  @override
  String get noEvents => 'Geen Gebeurtenisse Gevind Nie';

  @override
  String get noEventsPlanned =>
      'Daar is geen gebeurtenisse beplan vir hierdie dag nie.';

  @override
  String get dateType => 'Gebruik datum/tyd';

  @override
  String get hourLetter => 'h';

  @override
  String get minuteShort => 'min';

  @override
  String get local => 'Plaaslike';

  @override
  String timeSelection(Object type) {
    return 'Tyd en datums is in $type tyd';
  }

  @override
  String get delivery => 'Delivery';

  @override
  String get ground => 'Grond';

  @override
  String get tower => 'Toring';

  @override
  String get approach => 'Benadering';

  @override
  String get center => 'Area';

  @override
  String get atcFull => 'Lugverkeerkontroleerder';

  @override
  String get flyingNoOfp => 'Vlieg sonder \'n geldige vlugplan.';

  @override
  String get shareEvent => 'Deel Gebeur';

  @override
  String get partakingAirports => 'Neem deel';

  @override
  String get endTime => 'Eind Tyd';

  @override
  String get startTime => 'Begin Tyd';

  @override
  String get organizer => 'Organiseerder';

  @override
  String get eventDetails => 'Gebeurtenisbesonderhede';

  @override
  String get eventReminderRemoved => 'Gebeurtenisherinnering is verwyder.';

  @override
  String get eventReminderSet => 'Geleentheidsherinnering is bygevoeg.';

  @override
  String get eventAdd => 'Voeg gebeurtenis by';

  @override
  String get eventRemove => 'Verwyder gebeurtenis';

  @override
  String get minutes => 'minute';

  @override
  String get hours => 'ure';

  @override
  String get watchAd => 'Kyk Advertensie';

  @override
  String get flightsLog => 'VATSIM-profiel';

  @override
  String get flightInProgress => 'Vlug aan die gang';

  @override
  String get noFlightHistory =>
      'Geen geskiedenis. Kontroleer asseblief jou Vatsim ID in die app-instellings';

  @override
  String get helipad => 'Helikopterlandingsplek';

  @override
  String get runways => 'Vlugbane';

  @override
  String get vatsimId => 'Vatsim ID';

  @override
  String get about => 'Oor';

  @override
  String get latestHundredFlights => 'JVATSIM-profiel en vlugte';

  @override
  String get searchAirportInformation => 'Soek lughaweninligting en METAR';

  @override
  String get vatsimEventsDescription => 'Huidige en komende gebeure op Vatsim';

  @override
  String get settingsDescription => 'Voorkeure en bydraes';

  @override
  String get aboutAppDescription => 'Inligting oor die app en ontwikkelaar';

  @override
  String get totalFlightCount => 'Totale vlugte';

  @override
  String get viewMore => 'Bekyk meer';

  @override
  String get events => 'Gebeure';

  @override
  String get supportApp =>
      'Love using the app? Help us keep improving by making a contribution below! Your support goes a long way. And while you\'re here, we\'d appreciate it if you could take a moment to rate us on Google Play or the App Store. Thank you!';

  @override
  String get donatePaypal => 'Koop vir my koffie';

  @override
  String get pilotHours => 'Ure as vlieënier';

  @override
  String get atcHours => 'Lugverkeersbeheer-ure';

  @override
  String get supHours => 'Ure as toesighouer';

  @override
  String get generalSettings => 'Algemene instellings';

  @override
  String get vatsimSettings => 'VATSIM instellings';

  @override
  String get supportTheApp => 'Ondersteun die toepassing';

  @override
  String get cruiseAltitude => 'Cruise hoogte';

  @override
  String get cruiseSpeed => 'Cruise spoed';

  @override
  String get navbarStyle => 'Navigasiebalk-styl';

  @override
  String get loginWithVatsim => 'Meld aan met jou VATSIM-rekening';

  @override
  String get loginWithVatsimLabel =>
      'Sien profielbesonderhede, vluggeskiedenis, en meer';

  @override
  String get authWithVatsim => 'Meld aan met VATSIM';

  @override
  String get logout => 'Teken af';

  @override
  String get configLoadFail =>
      'Kon nie die toepassing se konfigurasie laai nie. Begin asseblief die toepassing weer.';

  @override
  String get screenNotFound => 'Die skerm waarna jy soek, bestaan nie.';
}
