import '../../data/entity/_aircraft.dart';

abstract class AircraftRepository {
  Future<Aircraft?> aircraftDetails(String icaoId);
}