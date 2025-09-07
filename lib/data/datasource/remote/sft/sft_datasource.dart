import 'package:sim_flights_tracker/core/constants/sim_network.dart';
import 'package:sim_flights_tracker/data/entity/_aircraft.dart';
import 'package:sim_flights_tracker/data/entity/_airline.dart';
import 'package:sim_flights_tracker/data/entity/_airport.dart';
import 'package:sim_flights_tracker/data/entity/_atc_history.dart';
import 'package:sim_flights_tracker/data/entity/_authed_user_details.dart';
import 'package:sim_flights_tracker/data/entity/_controller.dart';
import 'package:sim_flights_tracker/data/entity/_data_summary.dart';
import 'package:sim_flights_tracker/data/entity/_flight.dart';
import 'package:sim_flights_tracker/data/entity/_flight_track.dart';
import 'package:sim_flights_tracker/data/entity/_flights_history.dart';
import 'package:sim_flights_tracker/data/entity/_sft_event.dart';
import 'package:sim_flights_tracker/data/entity/_sft_event_summary.dart';
import 'package:sim_flights_tracker/data/entity/_vatsim_transceiver.dart';
import 'package:sim_flights_tracker/data/entity/_vatsim_user_hours.dart';

import '../../../entity/_flight_plan_history_item.dart';

abstract class SftDatasource {

  /// Based on the provided network, which can be either Vatsim or Ivao
  /// Get a list of flights and controllers.
  /// [network] Sim Network, either Vatsim or Ivao
  Future<DataSummary> getLiveDataSummary(SimNetwork network);

  ///  Get flight details matching the provided [callsign]
  ///  Based on the provided [network]
  Future<Flight?> getFlightDetails(String callsign, SimNetwork network);

  /// Get controller details matching provided [callsign];
  Future<Controller?> getControllerDetails(String callsign, SimNetwork network);

  /// Get airport details matching provided [icaoId]
  Future<Airport?> getAirport({String icaoId});

  /// Search airports matching the provided [query] string
  Future<List<Airport>>  searchAirports(String query);

  /// Get airline details matching provided [icaoId]
  Future<Airline?> getAirline(String icaoId);

  /// Get metar information for provided airport [icaoId]
  Future<String> getAirportMetar(String icaoId);

  /// Get aircraft details matching provided [icaoId]
  Future<Aircraft?> getAircraft(String icaoId);

  /// Get event details matching provided [eventId]
  Future<SftEvent?> getEventDetails(int eventId, SimNetwork simNetwork);

  /// Get list of events for provided network, only Vatsim supported for now
  Future<List<SftEventSummary>> getEvents(SimNetwork network);

  /// Get a list of Vatsim transceivers
  Future<List<VatsimTransceiver>> getVatsimTransceivers();

  /// Get Vatsim flight history
  Future<FlightsHistory> getVatsimFlightsHistory(int vatsimId, int pageOffset);

  /// Get Vatsim flight plan history for the latest 50 flights;
  Future<List<FlightPlanHistoryItem>> getVatsimFlightPlanHistory(int vatsimId);

  /// Get Vatsim atc history for provided vatsim id;
  Future<AtcHistory> getVatsimAtcHistory(int vatsimId);

  Future<FlightTrack> getFlightTrack(String callsign, SimNetwork network);

  Future<VatsimUserHours?> getVatsimUserHours(int vatsimId);

  Future<String?> startVatsimAuth();

  Future<AuthedUserDetails?> getAuthedUserDetails(String authId);

  Future<String> vatsimLogout(String authId);

}
