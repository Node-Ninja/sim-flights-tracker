import 'package:flutter/cupertino.dart';

import '../config/i10n/generated/app_localizations.dart';


class Facilities {
  Map<String, Map<String, String>> getFacilities(BuildContext context) {
    return {
      '0': {
        'id': '0',
        'short': 'OBS',
        'long': AppLocalizations.of(context)!.observers
      },
      '1': {
        'id': '1',
        'short': 'FSS',
        'long': 'Flight Service Station'
      },
      '2': {
        'id': '2',
        'short': 'DEL',
        'long': AppLocalizations.of(context)!.delivery
      },
      '3': {
        'id': '3',
        'short': 'GND',
        'long': AppLocalizations.of(context)!.ground
      },
      '4': {
        'id': '4',
        'short': 'TWR',
        'long': AppLocalizations.of(context)!.tower
      },
      '5': {
        'id': '5',
        'short': 'APP',
        'long': AppLocalizations.of(context)!.approach
      },
      '6': {
        'id': '6',
        'short': 'CTR',
        'long': AppLocalizations.of(context)!.center
      },
    };
  }

  List<Map<String, String>> getFacilitiesList() {
    return [
      {
        'id': '0',
        'short': 'OBS',
        'long': 'Observer'
      },
      {
        'id': '1',
        'short': 'FSS',
        'long': 'Flight Service Station'
      },
      {
        'id': '2',
        'short': 'DEL',
        'long': 'Clearance Delivery'
      },
      {
        'id': '3',
        'short': 'GND',
        'long': 'Ground'
      },
      {
        'id': '4',
        'short': 'TWR',
        'long': 'Tower'
      },
      {
        'id': '5',
        'short': 'APP',
        'long': 'Approach/Departure'
      },
       {
        'id': '6',
        'short': 'CTR',
        'long': 'Center'
      },
    ];
  }
}