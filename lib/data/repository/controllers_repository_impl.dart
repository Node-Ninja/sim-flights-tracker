import 'package:sim_flights_tracker/core/constants/sim_network.dart';
import 'package:sim_flights_tracker/data/entity/_controller.dart';
import 'package:sim_flights_tracker/data/entity/_vatsim_transceiver.dart';
import 'package:sim_flights_tracker/domain/repository/controllers_repository.dart';

import '../datasource/remote/sft/sft_datasource.dart';

class ControllersRepositoryImpl implements ControllersRepository {
  final SftDatasource _datasource;

  ControllersRepositoryImpl(
      SftDatasource remoteDataSource): _datasource = remoteDataSource;

  @override
  Future<List<VatsimTransceiver>> vatsimTransceivers() async {
    return await _datasource.getVatsimTransceivers();
  }

  @override
  Future<Controller?> controllerDetails(String callsign, SimNetwork network) async {
    return _datasource.getControllerDetails(callsign, network);
  }

}