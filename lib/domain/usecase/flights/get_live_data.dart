import 'package:sim_flights_tracker/core/constants/sim_network.dart';
import 'package:sim_flights_tracker/core/dependency_injection/use_case.dart';
import 'package:sim_flights_tracker/data/entity/_data_summary.dart';

import '../../repository/flights_repository.dart';

class GetLiveDataUseCase implements UseCase<DataSummary, LiveDataSummaryParams> {
  final FlightsRepository _repository;

  GetLiveDataUseCase(FlightsRepository repo): _repository = repo;

  @override
  Future<DataSummary> call(LiveDataSummaryParams params) async {
    return await _repository.liveDataSummary(params.network);
  }
}

class LiveDataSummaryParams {
  final SimNetwork network;

  LiveDataSummaryParams({required this.network});
}