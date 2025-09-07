import 'package:sim_flights_tracker/core/constants/sim_network.dart';
import 'package:sim_flights_tracker/core/dependency_injection/use_case.dart';
import 'package:sim_flights_tracker/data/entity/_flight_track.dart';
import 'package:sim_flights_tracker/domain/repository/flights_repository.dart';

class GetFlightTrackUseCase implements UseCase<FlightTrack?, FlightTrackParams> {
  final FlightsRepository _repository;

  GetFlightTrackUseCase(FlightsRepository repo): _repository = repo;

  @override
  Future<FlightTrack?> call(FlightTrackParams params) async {
    return await _repository.flightTrack(params.callsign, params.network);
  }


}

class FlightTrackParams {
  final String callsign;
  final SimNetwork network;

  FlightTrackParams({required this.callsign, required this.network});
}