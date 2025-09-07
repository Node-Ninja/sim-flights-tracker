import 'package:sim_flights_tracker/core/constants/sim_network.dart';
import 'package:sim_flights_tracker/core/dependency_injection/use_case.dart';
import 'package:sim_flights_tracker/domain/repository/flights_repository.dart';

import '../../../data/entity/_flight.dart';

class GetFlightDetailsUseCase implements UseCase<Flight?, FlightDetailsParams> {
  final FlightsRepository _repository;

  GetFlightDetailsUseCase(FlightsRepository repo): _repository = repo;

  @override
  Future<Flight?> call(FlightDetailsParams params) async {
    return await _repository.flightDetails(params.callSign, params.network);
  }
}

class FlightDetailsParams {
  final String callSign;
  final SimNetwork network;

  FlightDetailsParams({required this.callSign, required this.network});
}