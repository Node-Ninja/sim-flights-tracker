import '../../data/entity/_airline.dart';

abstract class AirlinesRepository {
  Future<Airline?> airlineDetails(String icaoId);
}