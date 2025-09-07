import 'package:sim_flights_tracker/core/constants/sim_network.dart';

import '../../data/entity/_sft_event_summary.dart';
import '../../data/entity/_sft_event.dart';

abstract class EventsRepository {
  Future<List<SftEventSummary>> getEvents(SimNetwork network);

  Future<SftEvent?> getEventDetails(int eventId, SimNetwork network);
}