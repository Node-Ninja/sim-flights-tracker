import 'package:sim_flights_tracker/data/entity/_airline.dart';
import 'package:sim_flights_tracker/domain/repository/airlines_repository.dart';

import '../datasource/remote/sft/sft_datasource.dart';

class AirlinesRepositoryImpl implements AirlinesRepository {
  final SftDatasource _datasource;

  AirlinesRepositoryImpl(
      SftDatasource remoteDataSource): _datasource = remoteDataSource;

  @override
  Future<Airline?> airlineDetails(String icaoId) async {
    return await _datasource.getAirline(icaoId);
  }

}