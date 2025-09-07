import 'package:sim_flights_tracker/core/constants/sim_network.dart';
import 'package:sim_flights_tracker/core/dependency_injection/use_case.dart';
import 'package:sim_flights_tracker/data/entity/_controller.dart';
import 'package:sim_flights_tracker/domain/repository/controllers_repository.dart';

class GetControllerDetailsUseCase implements UseCase<Controller?, ControllerDetailsParams> {
  final ControllersRepository _repository;

  GetControllerDetailsUseCase(ControllersRepository repo): _repository = repo;

  @override
  Future<Controller?> call(ControllerDetailsParams params) async {
    return await _repository.controllerDetails(params.callsign, params.network);
  }
}

class ControllerDetailsParams {
  final String callsign;
  final SimNetwork network;

  ControllerDetailsParams({ required this.callsign, required this.network });
}