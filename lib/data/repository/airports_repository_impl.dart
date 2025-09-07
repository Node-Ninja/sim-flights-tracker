import 'package:sim_flights_tracker/data/entity/_airport.dart';
import 'package:sim_flights_tracker/domain/repository/airports_repository.dart';

import '../datasource/remote/sft/sft_datasource.dart';

class AirportsRepositoryImpl implements AirportsRepository {
  final SftDatasource _datasource;

  AirportsRepositoryImpl(
      SftDatasource remoteDataSource): _datasource = remoteDataSource;

  @override
  Future<Airport?> airportDetails(String icaoId) async {
    return await _datasource.getAirport(icaoId: icaoId);
  }

  @override
  Future<String> airportMetar(String icaoId) async {
    return await _datasource.getAirportMetar(icaoId);
  }

  @override
  Future<List<Airport>> searchAirports(String query) async {
    return await _datasource.searchAirports(query);
  }
  
}