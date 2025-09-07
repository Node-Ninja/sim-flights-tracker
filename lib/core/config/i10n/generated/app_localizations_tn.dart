// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tswana (`tn`).
class AppLocalizationsTn extends AppLocalizations {
  AppLocalizationsTn([String locale = 'tn']) : super(locale);

  @override
  String get network => 'Neteweke';

  @override
  String get flights => 'Difofane';

  @override
  String get controllers => 'Balaodi';

  @override
  String get observers => 'Balekodi';

  @override
  String get home => 'Gae';

  @override
  String get map => 'Mmepe';

  @override
  String get menu => 'Menu';

  @override
  String get altitude => 'Bogodimo';

  @override
  String get speed => 'Lebelo';

  @override
  String get heading => 'Ntlha';

  @override
  String get totalDistance => 'Sekgala';

  @override
  String get distanceTravelled => 'Tsamaile Sekgala';

  @override
  String get distanceRemaining => 'Go Setse Sekgala';

  @override
  String get timeToDestination => 'Nako ya go goroga';

  @override
  String get etaLocal => 'ETA';

  @override
  String get etaZulu => 'Nako ya Zulu';

  @override
  String get country => 'Naga';

  @override
  String get name => 'Leina';

  @override
  String get callsign => 'Leina La Pitso';

  @override
  String get airlineDetails => 'Ka ga Kgamphani';

  @override
  String get flightDetails => 'Ka ga sefofane';

  @override
  String captain(Object name) {
    return 'Mokaptene $name';
  }

  @override
  String get aircraft => 'Sefofane';

  @override
  String get company => 'Kgamphani';

  @override
  String get arrived => 'Gorogile';

  @override
  String get enRoute => 'Mo Tseleng';

  @override
  String get approaching => 'E Ya Atamela';

  @override
  String get circuits => 'Ya Dikologa';

  @override
  String get virtualAirline => 'Kgamphani ya maitirelo';

  @override
  String get flag => 'Folaga';

  @override
  String get region => 'Karolo';

  @override
  String get clearance => 'Tumelano ya go fofa';

  @override
  String get boarding => 'Ba namela';

  @override
  String get departing => 'Ya Tloga';

  @override
  String get arrivingShortly => 'E gaufi';

  @override
  String get unknown => 'Ga go itsagale';

  @override
  String get notAvailable => 'Ga e yo';

  @override
  String get noOFP => 'Ga gona morero wa go fofa.';

  @override
  String get waitingOFP => 'Emetse morero wa go fofa';

  @override
  String get unknownAircraft => 'Sefofane ga se itsagale';

  @override
  String get noFlightDetails =>
      'Dintlha ka ga sefofane ga di yo. Leka gape mo nakwaneng.';

  @override
  String get flightDisconnected =>
      'Sefofane se ga se sa le yo. Ka kopo boela morago o tlhophe se sengwe.';

  @override
  String get errorFlightLoad =>
      'Dintlha ka sefofane se ga di yo. Ka kopo boela morago o tlhophe se sengwe, kgotsa o leke gape mo nakwaneng. Maitshwarelo ka se.';

  @override
  String get airportSearch => 'Senka Boemafofane';

  @override
  String get vatsimEvents => 'Ditiragatso tsa Vatsim';

  @override
  String get settings => 'Dipaakanyo';

  @override
  String get atcNetwork => 'Neteweke ya ATC';

  @override
  String get language => 'Loleme';

  @override
  String get aboutApp =>
      'Sim Flights Tracker ke sediriswa se se latelang difofane tse phelang mo marangweng a Vatsim le Ivao. Sediriswa se se dirisa dintlha tse di gatisitsweng phatlhalatsa tse tswang mo Vatsim le tse tswang mo Ivao.';

  @override
  String get appDisclaimer =>
      'Maina a dikgamphani le ditshupo ke matshwao a kgwebo™ kgotsa a ngwadisitsweng® mme a sala e le thepa ya beng ba tsone. Tiriso ya tsone ga e kaye tsholofetso nngwe le nngwe ya go kopanela kgotsa go amogelwa ke bone.';

  @override
  String get loaderText => 'Ema gannyane';

  @override
  String get searchATC => 'Senka ka nomoro ya karolo kgotsa ka nomoro ya ICAO';

  @override
  String get noControllers =>
      'Ga gona balaodi ba ba tshwanang le tshenko ya gago. Ka kopo, leka gape.';

  @override
  String get searchAirports =>
      'Senka ka leina la boemafofane kgotsa ka nomoro ya ICAO';

  @override
  String get airportsInfo =>
      'Senka o fitlhele dintlha ka boemafofane lefatshe ka bophara.';

  @override
  String get oops => 'Go senyegile sengwe. Ka kopo,leka gape monakwaneng.';

  @override
  String get noFlightsQuery =>
      'Ga gona difofane tse di tshwanang le tshenki ya gago. Ka kopo leka gape.';

  @override
  String get searchWithFlightNumber => 'Senka ka nomoro ya sefofane';

  @override
  String get onlineControllers => 'Balaodi ba leng teng';

  @override
  String get identification => 'Boitshupo';

  @override
  String get surface => 'Lapa';

  @override
  String get hasLights => 'E na le mabone?';

  @override
  String get yes => 'Ee';

  @override
  String get no => 'Aowa';

  @override
  String get viewDetails => 'Bona dintlha';

  @override
  String get elevation => 'Bogodimo';

  @override
  String get lostInternetConnection =>
      'E latlhile kgokagano le mafaratlhatlha. Leka gape mo nakwaneng';

  @override
  String get hasNotStarted => 'Ga se e simolole';

  @override
  String get startingNow => 'E simolotse';

  @override
  String get inProgress => 'E tsweletse';

  @override
  String get endingNow => 'E a fela';

  @override
  String get hasEnded => 'E fedile';

  @override
  String get tapToExit => 'Tobetsa morago gape go tswa';

  @override
  String get variable => 'Ya fetoga';

  @override
  String get noMetar => 'Ga gona tsa boemo ba legodimo.';

  @override
  String get windCalm => 'Phefo e didimetse';

  @override
  String get goBack => 'Boela Morago';

  @override
  String get noEvents => 'Ga Gona Ditiragatso';

  @override
  String get noEventsPlanned => 'Ga gona ditiragatso mo letsatsing le';

  @override
  String get dateType => 'Bontsha nako ka';

  @override
  String get hourLetter => 'H';

  @override
  String get minuteShort => 'min';

  @override
  String get local => 'Gae';

  @override
  String timeSelection(Object type) {
    return 'Dinako di bontshwa ka nako ya $type';
  }

  @override
  String get delivery => 'Merero';

  @override
  String get ground => 'Fatshe';

  @override
  String get tower => 'Tower';

  @override
  String get approach => 'Go Atamela';

  @override
  String get center => 'Center';

  @override
  String get atcFull => 'Molaodi wa difofane';

  @override
  String get flyingNoOfp => 'Se fofa gontle ga morero wa go fofa';

  @override
  String get shareEvent => 'Romela Tiragalo';

  @override
  String get partakingAirports => 'Batsaa Karolo';

  @override
  String get endTime => 'E fela';

  @override
  String get startTime => 'E Simolola';

  @override
  String get organizer => 'Ke Ya';

  @override
  String get eventDetails => 'Ka Ga Tiragalo';

  @override
  String get eventReminderRemoved => 'Kgopotso ya tiragalo e e tlositswe.';

  @override
  String get eventReminderSet => 'Kgopotso ya tiragalo e e tsentswe.';

  @override
  String get eventAdd => 'Tsenya kgopotso';

  @override
  String get eventRemove => 'Tlosa kgopotso';

  @override
  String get minutes => 'metsotso';

  @override
  String get hours => 'diura';

  @override
  String get watchAd => 'Leba Papatso';

  @override
  String get flightsLog => 'Profaile ya VATSIM';

  @override
  String get flightInProgress => 'Sefofane se se tsweletse';

  @override
  String get noFlightHistory =>
      'Ga gona histori. Ka kopo, lekola ID ya Vatsim mo dipaakanyong tsa app';

  @override
  String get helipad => 'Helipad';

  @override
  String get runways => 'Ditsela';

  @override
  String get vatsimId => 'ID ya Vatsim';

  @override
  String get about => 'Ka ga';

  @override
  String get latestHundredFlights => 'Profailo ya VATSIM le difofane';

  @override
  String get searchAirportInformation =>
      'Batla tshedimosetso ya boemafofane le METAR';

  @override
  String get vatsimEventsDescription => 'Ditiragatso tse di tlang mo Vatsim';

  @override
  String get settingsDescription => 'Dikgetho le dikabelo';

  @override
  String get aboutAppDescription => 'Tshedimosetso ka ga app le mong wa yone';

  @override
  String get totalFlightCount => 'Palogotlhe ya difofane';

  @override
  String get viewMore => 'Tse dingwe';

  @override
  String get events => 'Ditiragatso';

  @override
  String get supportApp =>
      'Love using the app? Help us keep improving by making a contribution below! Your support goes a long way. And while you\'re here, we\'d appreciate it if you could take a moment to rate us on Google Play or the App Store. Thank you!';

  @override
  String get donatePaypal => 'Koleka';

  @override
  String get pilotHours => 'Palogotlhe ya go fofa';

  @override
  String get atcHours => 'Palogotlhe ya go laola';

  @override
  String get supHours => 'Palogolthe ya molaodi';

  @override
  String get generalSettings => 'Dikgetho';

  @override
  String get vatsimSettings => 'Dikgetho tsa VATSIM';

  @override
  String get supportTheApp => 'Tshegetsa app';

  @override
  String get cruiseAltitude => 'Bogodimo';

  @override
  String get cruiseSpeed => 'Lebelo';

  @override
  String get navbarStyle => 'Mokgwa wa Navbar';

  @override
  String get loginWithVatsim => 'Tsena ka akhaonto ya gago ya VATSIM';

  @override
  String get loginWithVatsimLabel =>
      'Leba dintlha tsa profailo, nalane ya difofane, le tse dingwe';

  @override
  String get authWithVatsim => 'Tsena ka VATSIM';

  @override
  String get logout => 'Tswaya';

  @override
  String get configLoadFail => 'Go sengwe se se ';

  @override
  String get screenNotFound =>
      'Tsebe e o e batlang ga e yo. Tobetse kwa tlase go boela morago.';
}
