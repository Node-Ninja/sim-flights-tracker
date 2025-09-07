import 'package:sim_flights_tracker/core/dependency_injection/use_case.dart';
import 'package:sim_flights_tracker/domain/repository/airports_repository.dart';

import '../../../data/entity/_airport.dart';

class GetAirportUseCase implements UseCase<Airport?, AirportDetailsParams> {
  final AirportsRepository _repository;

  GetAirportUseCase(AirportsRepository repo): _repository = repo;

  @override
  Future<Airport?> call(AirportDetailsParams params) async {
    return await _repository.airportDetails(params.icaoId);
  }
}

class AirportDetailsParams {
  final String icaoId;

  AirportDetailsParams({ required this.icaoId});
}