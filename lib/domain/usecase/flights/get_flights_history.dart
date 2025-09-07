import 'package:sim_flights_tracker/core/dependency_injection/use_case.dart';
import 'package:sim_flights_tracker/data/entity/_flights_history.dart';
import 'package:sim_flights_tracker/domain/repository/flights_repository.dart';

class GetFlightsHistoryUseCase implements UseCase<FlightsHistory, FlightsHistoryParams> {
  final FlightsRepository _repository;

  GetFlightsHistoryUseCase(FlightsRepository repo): _repository = repo;

  @override
  Future<FlightsHistory> call(FlightsHistoryParams params) async {
    return await _repository.flightsHistory(params.networkId, params.pageOffset);
  }
}

class FlightsHistoryParams {
  final int networkId;
  final int pageOffset;

  FlightsHistoryParams({required this.networkId, required this.pageOffset});
}