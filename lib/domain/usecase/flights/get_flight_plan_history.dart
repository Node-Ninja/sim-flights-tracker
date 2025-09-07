import 'package:sim_flights_tracker/core/dependency_injection/use_case.dart';
import 'package:sim_flights_tracker/domain/repository/flights_repository.dart';

import '../../../data/entity/_flight_plan_history_item.dart';

class GetFlightPlanHistoryUseCase implements UseCase<List<FlightPlanHistoryItem>, FlightPlanHistoryParams> {
  final FlightsRepository _repository;

  GetFlightPlanHistoryUseCase(FlightsRepository repo): _repository = repo;

  @override
  Future<List<FlightPlanHistoryItem>> call(FlightPlanHistoryParams params) async {
    return await _repository.flightPlanHistory(params.vatsimId);
  }
}

class FlightPlanHistoryParams {
  final int vatsimId;

  FlightPlanHistoryParams({required this.vatsimId});
}