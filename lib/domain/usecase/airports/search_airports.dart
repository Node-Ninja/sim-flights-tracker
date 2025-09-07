import 'package:sim_flights_tracker/core/dependency_injection/use_case.dart';

import '../../../data/entity/_airport.dart';
import '../../repository/airports_repository.dart';

class SearchAirportsUseCase implements UseCase<List<Airport>, SearchAirportsParams> {
  final AirportsRepository _repository;

  SearchAirportsUseCase(AirportsRepository repo): _repository = repo;

  @override
  Future<List<Airport>> call(SearchAirportsParams params) async {
    return await _repository.searchAirports(params.query);
  }
}

class SearchAirportsParams {
  final String query;

  SearchAirportsParams({ required this.query });
}