import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

import '../../core/config/i10n/generated/app_localizations.dart';

String intToTimeLeft(int value, BuildContext context) {
  int h, m;

  h = value ~/ 3600;

  m = ((value - h * 3600)) ~/ 60;

  String hourLeft = h.toString().length < 2 ? '0$h' : h.toString();

  String minuteLeft =
  m.toString().length < 2 ? '0$m' : m.toString();

  String result = (hourLeft == '00') ? '$minuteLeft ${AppLocalizations.of(context)!.minuteShort}' : '$hourLeft${AppLocalizations.of(context)!.hourLetter} ${minuteLeft}m';

  return result;
}

List<int> timeValues(int value) {
  int h, m, s;

  h = value ~/ 3600;

  m = ((value - h * 3600)) ~/ 60;

  s = value - (h * 3600) - (m * 60);

  return [h,m,s];
}

int calculateGeoDistance({
  required double startLatitude,
  required double startLongitude,
  required double endLatitude,
  required double endLongitude
}) {
  //  use geo-locator to calculate distance between two coordinates
  var geoDistance = Geolocator.distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude);

  return (geoDistance * 0.000539956803).floor();
}