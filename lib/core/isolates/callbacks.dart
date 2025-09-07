import 'dart:convert';

import 'package:sim_flights_tracker/data/entity/_air_traffic_control_sector.dart';

class IsolateCallbacks {
  static Future<List<AirTrafficControlSector>> getAirTrafficControlSectors(String rootBundle) async {
    var atcSectors = <AirTrafficControlSector>[];

    final jsonData = json.decode(rootBundle);
    atcSectors = List<AirTrafficControlSector>.from(jsonData.map((sector) => AirTrafficControlSector.fromJson(sector)));

    return atcSectors;
  }
}