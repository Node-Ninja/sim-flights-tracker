import 'package:sim_flights_tracker/core/dependency_injection/use_case.dart';
import 'package:sim_flights_tracker/data/entity/_vatsim_transceiver.dart';
import 'package:sim_flights_tracker/domain/repository/controllers_repository.dart';

class GetVatsimTransceiversUseCase implements UseCase<List<VatsimTransceiver>, String> {
  final ControllersRepository _repository;

  GetVatsimTransceiversUseCase(ControllersRepository repo): _repository = repo;

  @override
  Future<List<VatsimTransceiver>> call(String params) async{
    return await _repository.vatsimTransceivers();
  }
}
