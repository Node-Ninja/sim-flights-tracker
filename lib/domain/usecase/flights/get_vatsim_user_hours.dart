import 'package:sim_flights_tracker/core/dependency_injection/use_case.dart';
import 'package:sim_flights_tracker/data/entity/_vatsim_user_hours.dart';

import '../../repository/flights_repository.dart';

class GetVatsimUserHoursUseCase implements UseCase<VatsimUserHours?, int> {
  final FlightsRepository _repository;

  GetVatsimUserHoursUseCase(FlightsRepository repo): _repository = repo;

  @override
  Future<VatsimUserHours?> call(int params) async {
    return await _repository.vatsimUserHours(params);
  }


}