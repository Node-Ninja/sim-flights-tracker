import 'package:sim_flights_tracker/data/entity/_flight.dart';
import 'package:sim_flights_tracker/data/entity/_flight_summary.dart';
import 'package:sim_flights_tracker/data/entity/_sft_event_summary.dart';

class Mock {
  static final Flight mockFlight =  Flight(0, '', 'CallSign', 0, 0, 0, 0, 0, 'Test', null);
  static final FlightSummary mockFlightSummary = FlightSummary('CallSign', 0, 0, null, 0, 0, 0);
  static final SftEventSummary mockEventSummary = SftEventSummary(0, 'Test', DateTime.now(), DateTime.now(), 'https://picsum.photos/200/80');
}