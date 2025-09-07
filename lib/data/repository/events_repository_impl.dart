import 'package:sim_flights_tracker/core/constants/sim_network.dart';
import 'package:sim_flights_tracker/data/entity/_sft_event_summary.dart';
import 'package:sim_flights_tracker/data/entity/_sft_event.dart';
import 'package:sim_flights_tracker/domain/repository/events_repository.dart';

import '../datasource/remote/sft/sft_datasource.dart';

class EventsRepositoryImpl implements EventsRepository {
  final SftDatasource _datasource;

  EventsRepositoryImpl(
      SftDatasource remoteDataSource): _datasource = remoteDataSource;

  @override
  Future<List<SftEventSummary>> getEvents(SimNetwork network) async {
    return await _datasource.getEvents(network);
  }

  @override
  Future<SftEvent?> getEventDetails(int eventId, SimNetwork simNetwork) async {
    return await _datasource.getEventDetails(eventId, simNetwork);
  }

}