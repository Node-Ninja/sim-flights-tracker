import 'package:sim_flights_tracker/core/constants/sim_network.dart';
import 'package:sim_flights_tracker/core/dependency_injection/use_case.dart';
import 'package:sim_flights_tracker/data/entity/_sft_event_summary.dart';

import '../../repository/events_repository.dart';

class GetEventsUseCase implements UseCase<List<SftEventSummary>, EventsListParams> {
  final EventsRepository _repository;

  GetEventsUseCase(EventsRepository repo): _repository = repo;

  @override
  Future<List<SftEventSummary>> call(EventsListParams params) async {
    return await _repository.getEvents(params.network);
  }
}

class EventsListParams {
  final SimNetwork network;

  EventsListParams({ required this.network });
}