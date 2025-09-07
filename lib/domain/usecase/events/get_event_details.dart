import 'package:sim_flights_tracker/core/constants/sim_network.dart';
import 'package:sim_flights_tracker/core/dependency_injection/use_case.dart';
import 'package:sim_flights_tracker/domain/repository/events_repository.dart';

import '../../../data/entity/_sft_event.dart';

class GetEventDetailsUseCase implements UseCase<SftEvent?, EventDetailsParams> {
  final EventsRepository _repository;

  GetEventDetailsUseCase(EventsRepository repo): _repository = repo;

  @override
  Future<SftEvent?> call(EventDetailsParams params) async {
    return await _repository.getEventDetails(params.eventId, params.simNetwork);
  }
}

class EventDetailsParams {
  final int eventId;
  final SimNetwork simNetwork;

  EventDetailsParams({ required this.eventId, required this.simNetwork });
}