import 'package:sim_flights_tracker/core/dependency_injection/use_case.dart';
import 'package:sim_flights_tracker/data/entity/_aircraft.dart';
import 'package:sim_flights_tracker/domain/repository/aircraft_repository.dart';

class GetAircraftDetailsUseCase implements UseCase<Aircraft?, AircraftDetailsParams> {
  final AircraftRepository _repository;

  GetAircraftDetailsUseCase(AircraftRepository repo): _repository = repo;

  @override
  Future<Aircraft?> call(AircraftDetailsParams params) async {
    return _repository.aircraftDetails(params.aircraftCode);
  }
}

class AircraftDetailsParams {
  final String aircraftCode;

  AircraftDetailsParams({ required this.aircraftCode });
}