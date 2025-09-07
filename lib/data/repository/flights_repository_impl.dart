import 'package:sim_flights_tracker/core/constants/sim_network.dart';
import 'package:sim_flights_tracker/data/datasource/remote/sft/sft_datasource.dart';
import 'package:sim_flights_tracker/data/entity/_atc_history.dart';
import 'package:sim_flights_tracker/data/entity/_data_summary.dart';
import 'package:sim_flights_tracker/data/entity/_flight.dart';
import 'package:sim_flights_tracker/data/entity/_flight_plan_history_item.dart';
import 'package:sim_flights_tracker/data/entity/_flight_track.dart';
import 'package:sim_flights_tracker/data/entity/_flights_history.dart';
import 'package:sim_flights_tracker/data/entity/_vatsim_user_hours.dart';
import 'package:sim_flights_tracker/domain/repository/flights_repository.dart';

class FlightsRepositoryImpl implements FlightsRepository {
  final SftDatasource _datasource;

  FlightsRepositoryImpl(
      SftDatasource remoteDataSource): _datasource = remoteDataSource;

  @override
  Future<Flight?> flightDetails(String callsign, SimNetwork network) async {
    return await _datasource.getFlightDetails(callsign, network);
  }

  @override
  Future<DataSummary> liveDataSummary(SimNetwork network) async {
    return await _datasource.getLiveDataSummary(network);
  }

  @override
  Future<FlightsHistory> flightsHistory(int networkId, int pageOffset) async {
    return await _datasource.getVatsimFlightsHistory(networkId, pageOffset);
  }

  @override
  Future<List<FlightPlanHistoryItem>> flightPlanHistory(int vatsimId) async {
    return await _datasource.getVatsimFlightPlanHistory(vatsimId);
  }

  @override
  Future<FlightTrack> flightTrack(String callsign, SimNetwork network) async {
    return await _datasource.getFlightTrack(callsign, network);
  }

  @override
  Future<VatsimUserHours?> vatsimUserHours(int vatsimId) async {
    return await _datasource.getVatsimUserHours(vatsimId);
  }

  @override
  Future<AtcHistory> atcHistory(int networkId) async {
    return await _datasource.getVatsimAtcHistory(networkId);
  }
}