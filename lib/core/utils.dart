import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:intl/intl.dart';
import 'package:sim_flights_tracker/presentation/util/general_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/entity/_flight_summary.dart';
import '../domain/model/airport_extract.dart';
import '../presentation/util/bottom_sheets.dart';
import 'config/i10n/generated/app_localizations.dart';
import 'constants/controller_type.dart';
import 'constants/date_type.dart';
import 'constants/patterns.dart';
import 'constants/sim_network.dart';

Future<void> openBrowser(String url) async {
  try {
    Uri link = Uri.parse(url);

    if (!await launchUrl(link)) {
      throw Exception();
    }
  } catch (e) {
    showSnackBarNotification('Could not open browser. Please try again later.');
  }
}

LatLng getCenterLatLong(List<LatLng> latLongList) {
  double pi = math.pi / 180;
  double xpi = 180 / math.pi;
  double x = 0, y = 0, z = 0;

  if(latLongList.length==1)
  {
    return latLongList[0];
  }
  for (int i = 0; i < latLongList.length; i++) {
    double latitude = latLongList[i].latitude * pi;
    double longitude = latLongList[i].longitude * pi;
    double c1 = math.cos(latitude);
    x = x + c1 * math.cos(longitude);
    y = y + c1 * math.sin(longitude);
    z = z + math.sin(latitude);
  }

  int total = latLongList.length;
  x = x / total;
  y = y / total;
  z = z / total;

  double centralLongitude = math.atan2(y, x);
  double centralSquareRoot = math.sqrt(x * x + y * y);
  double centralLatitude = math.atan2(z, centralSquareRoot);

  return LatLng(centralLatitude*xpi,centralLongitude*xpi);
}

String convertDateTime(dynamic date, DateType currentDateTimePref, DateFormat dateFormat) {
  late DateTime dateTime;

  dateTime = date is String
      ? DateTime.parse(date)
      : date;

  var prefDateTime =  currentDateTimePref == DateType.local
      ? dateTime.toLocal()
      : dateTime.toUtc();

  return dateFormat.format(prefDateTime);
}

String minutesToStringDuration(int minutes) {
  var d = Duration(minutes:minutes);
  List<String> parts = d.toString().split(':');
  return '${parts[0].padLeft(2, '0')}h ${parts[1].padLeft(2, '0')}m';
}

Future<void> logScreenView(String screenName, String screenClass) async {
  //  Disabling. This needs Firebase to be setup and initialized.
  //  I commented all the Firebase code in the app for now, to make it easier to share this code with you.
  return;
  
  var analytics = FirebaseAnalytics.instance;

  if (screenName.isNotEmpty) {
    await analytics.logScreenView(
      screenName: screenName,
      screenClass: screenClass,
    );
  }
}

Future<void> logDonateButtonClick() async {
  var analytics = FirebaseAnalytics.instance;
  await analytics.logEvent(
      name: 'donate_button_click',
      parameters: {
        'dateTime': DateTime.now().toIso8601String()
      }
  );
}

String bannerAdUnitId() {
  final String bannerUnitId = Platform.isAndroid
      ? dotenv.get('BANNER_AD_UNIT_ID_ANDROID')
      : dotenv.get('BANNER_AD_UNIT_ID_IOS');

  return bannerUnitId;
}

String interstitialAdUnitId() {
  final String unitId = Platform.isAndroid
      ? dotenv.get('INTERSTITIAL_AD_UNIT_ID_ANDROID')
      : dotenv.get('INTERSTITIAL_AD_UNIT_ID_IOS');

  return unitId;
}

(String, String) getCleanCallSignAndBoundaryName(String areaControllerCallsign) {
  var callsign = areaControllerCallsign
      .replaceAll(ControllerType.center.code, '')
      .replaceAll(ControllerType.service.code, '');

  callsign = callsign.replaceAll(RegExp(r'_\d+'), '');
  var boundaryName = callsign.replaceAll('_', '-');

  return (callsign, boundaryName);
}

LatLng convertEPSG3857To4326(double x, double y) {
  const double originShift = 2 * math.pi * 6378137 / 2.0; // Earth radius in meters (WGS84)

  double lon = (y / originShift) * 180.0;

  double lat = (x / originShift) * 180.0;
  lat = 180.0 / math.pi *
      (2.0 * math.atan(math.exp(lat * math.pi / 180.0)) - math.pi / 2.0);

  return LatLng(lat, lon); // Mapbox expects Position(lng, lat)
}

String extractWindFromMetar(String metar, BuildContext context) {

  String? wind = ValidationPatterns.windTypeOne.firstMatch(metar)?.group(0);
  String? wind2 = ValidationPatterns.windTypeTwo.firstMatch(metar)?.group(0);
  String? wind3 = ValidationPatterns.windTypeThree.firstMatch(metar)?.group(0);
  String? wind4 = ValidationPatterns.windTypeFour.firstMatch(metar)?.group(0);

  if (wind != null) {
    wind = (wind == '00000KT') ? AppLocalizations.of(context)!.windCalm : '${wind.substring(0,3)} at ${wind.substring(3,5)} KT';
  }

  if (wind2 != null) {
    wind2 = AppLocalizations.of(context)!.variable;
  }

  if (wind3 != null) {
    wind3 = '${wind3.substring(0,3)} at ${wind3.substring(3,5)} KT';
  }

  if (wind4 != null) {
    wind4 = '${wind4.substring(0,3)} at ${wind4.substring(3,5)} KT';
  }

  return wind ?? wind2 ?? wind3 ?? wind4 ?? AppLocalizations.of(context)!.notAvailable;
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
}

Future<Set<Marker>> buildFlightMarkers(
  List<FlightSummary> flights,
  List<AirportExtract> airportData,
  Uint8List planeIcon,
  SimNetwork simNetwork
) async {
  Set<Marker> markers = {};

  for (var flight in flights) {

    markers.add(Marker(
      rotation: flight.heading.toDouble(),
      markerId: MarkerId(flight.callsign),
      icon: BitmapDescriptor.bytes(planeIcon, width: 13),
      position: LatLng(flight.latitude, flight.longitude),
      anchor: const Offset(0.5, 0.5),
      onTap: () {
        showMapFlightSummaryBottomSheet(flight, simNetwork, null, null);
      },
    ));
  }

  return markers;
}

Future<List<ProductDetails>> getProductDetails() async {
  // list of play products;
  final Set<String> productIds = {
    'support_light',
    'support_medium',
    'support_heavy',
    'support_super'
  };

  final ProductDetailsResponse response = await InAppPurchase.instance.queryProductDetails(productIds);

  if (response.notFoundIDs.isNotEmpty) {
    return [];
  }

  response.productDetails.sort((a, b) => a.rawPrice.compareTo(b.rawPrice));

  return response.productDetails;
}

Future<void> buyProduct(ProductDetails product) async {
  final purchaseProduct = PurchaseParam(productDetails: product);

  await InAppPurchase.instance.buyConsumable(purchaseParam: purchaseProduct, autoConsume: true);
}