import 'package:sim_flights_tracker/data/entity/_controller.dart';

import '../../core/constants/sim_network.dart';
import '../../data/entity/_vatsim_transceiver.dart';

abstract class ControllersRepository {
  Future<List<VatsimTransceiver>> vatsimTransceivers();

  Future<Controller?> controllerDetails(String callsign, SimNetwork network);
}