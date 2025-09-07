import 'package:sim_flights_tracker/core/dependency_injection/use_case.dart';
import 'package:sim_flights_tracker/domain/repository/airlines_repository.dart';

import '../../../data/entity/_airline.dart';

class GetAirlineUseCase implements UseCase<Airline?, AirlineDetailsParams> {
  final AirlinesRepository _repository;

  GetAirlineUseCase(AirlinesRepository repo): _repository = repo;

  @override
  Future<Airline?>  call(AirlineDetailsParams params) {
    return _repository.airlineDetails(params.icaoId);
  }

}

class AirlineDetailsParams {
  final String icaoId;
  AirlineDetailsParams({required this.icaoId});
}