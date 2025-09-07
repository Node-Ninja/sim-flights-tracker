import 'package:sim_flights_tracker/data/entity/_aircraft.dart';
import 'package:sim_flights_tracker/domain/repository/aircraft_repository.dart';

import '../datasource/remote/sft/sft_datasource.dart';

class AircraftRepositoryImpl implements AircraftRepository {
  final SftDatasource _datasource;

  AircraftRepositoryImpl(
      SftDatasource remoteDataSource): _datasource = remoteDataSource;

  @override
  Future<Aircraft?> aircraftDetails(String icaoId) async {
    return await _datasource.getAircraft(icaoId);
  }
  
}