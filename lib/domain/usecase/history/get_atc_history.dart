import 'package:sim_flights_tracker/core/dependency_injection/use_case.dart';
import 'package:sim_flights_tracker/data/entity/_atc_history.dart';
import 'package:sim_flights_tracker/domain/repository/flights_repository.dart';

class GetAtcHistoryUseCase implements UseCase<AtcHistory, int> {
  final FlightsRepository _repository;

  GetAtcHistoryUseCase(FlightsRepository repo): _repository = repo;

  @override
  Future<AtcHistory> call(int param) async {
    return await _repository.atcHistory(param);
  }

}