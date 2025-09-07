import 'package:sim_flights_tracker/core/dependency_injection/use_case.dart';

import '../../repository/airports_repository.dart';

class GetAirportMetarUseCase implements UseCase<String, AirportMetarParams> {
  final AirportsRepository _repository;

  GetAirportMetarUseCase(AirportsRepository repo): _repository = repo;

  @override
  Future<String> call(AirportMetarParams params) async {
    return await _repository.airportMetar(params.icaoId);
  }

}

class AirportMetarParams {
  final String icaoId;

  AirportMetarParams({ required this.icaoId });
}