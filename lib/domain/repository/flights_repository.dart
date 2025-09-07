import 'package:sim_flights_tracker/core/constants/sim_network.dart';
import 'package:sim_flights_tracker/data/entity/_atc_history.dart';
import 'package:sim_flights_tracker/data/entity/_flight_plan_history_item.dart';
import 'package:sim_flights_tracker/data/entity/_flight_track.dart';
import 'package:sim_flights_tracker/data/entity/_flights_history.dart';
import 'package:sim_flights_tracker/data/entity/_vatsim_user_hours.dart';

import '../../data/entity/_data_summary.dart';
import '../../data/entity/_flight.dart';

abstract class FlightsRepository {
  Future<DataSummary> liveDataSummary(SimNetwork network);

  Future<Flight?> flightDetails(String callsign, SimNetwork network);

  Future<FlightsHistory> flightsHistory(int networkId, int pageOffset);

  Future<List<FlightPlanHistoryItem>> flightPlanHistory(int networkId);

  Future<AtcHistory> atcHistory(int networkId);

  Future<FlightTrack> flightTrack(String callsign, SimNetwork network);

  Future<VatsimUserHours?> vatsimUserHours(int vatsimId);
}