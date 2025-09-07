import 'package:sim_flights_tracker/data/entity/_airport.dart';

abstract class AirportsRepository {
  Future<Airport?> airportDetails(String icaoId);

  Future<List<Airport>> searchAirports(String query);

  Future<String> airportMetar(String icaoId);
}