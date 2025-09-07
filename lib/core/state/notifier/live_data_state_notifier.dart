import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sim_flights_tracker/core/extensions/string_extensions.dart';
import 'package:sim_flights_tracker/core/state/provider/providers.dart';
import 'package:sim_flights_tracker/domain/usecase/controllers/get_vatsim_transceivers.dart';
import 'package:sim_flights_tracker/domain/usecase/history/get_atc_history.dart';

import '../../../data/entity/_controller_summary.dart';
import '../../../data/entity/_flight_summary.dart';
import '../../../domain/usecase/flights/get_flight_plan_history.dart';
import '../../../domain/usecase/flights/get_flights_history.dart';
import '../../../domain/usecase/flights/get_live_data.dart';
import '../../../domain/usecase/flights/get_vatsim_user_hours.dart';
import '../../constants/controller_type.dart';
import '../../constants/sim_network.dart';
import '../../dependency_injection/injection_container.dart';
import '../model/live_data_state.dart';

class LiveDataStateNotifier extends Notifier<LiveDataState> {
  @override
  LiveDataState build() => const LiveDataState();

  void filterControllers(String query, SimNetwork simNetwork) {
    if (simNetwork == SimNetwork.vatsim) {
      var vatsimControllerSearchQuery = query.toLowerCase();
      var filteredControllers = <ControllerSummary>[];

      if (vatsimControllerSearchQuery == '') {
        filteredControllers = state.vatsimControllers;
      } else {
        filteredControllers = state.vatsimControllers.where((controller) => controller.callsign
            .toLowerCase()
            .contains(vatsimControllerSearchQuery))
            .toList();
      }

      state = state.copyWith(filteredVatsimControllers: filteredControllers, vatsimControllersSearchQuery: vatsimControllerSearchQuery);
    }

    if (simNetwork == SimNetwork.ivao) {
      var ivaoControllerSearchQuery = query.toLowerCase();
      var filteredControllers = <ControllerSummary>[];

      if (ivaoControllerSearchQuery == '') {
        filteredControllers = state.vatsimControllers;
      } else {
        filteredControllers = state.vatsimControllers.where((controller) => controller.callsign
            .toLowerCase()
            .contains(ivaoControllerSearchQuery))
            .toList();
      }

      state = state.copyWith(filteredIvaoControllers: filteredControllers, ivaoControllersSearchQuery: ivaoControllerSearchQuery);
    }
  }

  void filterFlights(String query, SimNetwork simNetwork) {
    if (simNetwork == SimNetwork.vatsim) {
      var vatsimFlightSearchQuery = query.toLowerCase();
      var filteredFlights = <FlightSummary>[];

      if (vatsimFlightSearchQuery == '') {
        filteredFlights = state.vatsimFlights;
      } else {
        filteredFlights = state.vatsimFlights.where((flight) => flight.callsign
            .toLowerCase()
            .contains(vatsimFlightSearchQuery))
            .toList();
      }

      state = state.copyWith(filteredVatsimFlights: filteredFlights, vatsimFlightsSearchQuery: vatsimFlightSearchQuery);
    }

    if (simNetwork == SimNetwork.ivao) {
      var ivaoFlightSearchQuery = query.toLowerCase();
      var filteredFlights = <FlightSummary>[];

      if (ivaoFlightSearchQuery == '') {
        filteredFlights = state.ivaoFlights;
      } else {
        filteredFlights = state.ivaoFlights.where((flight) => flight.callsign
            .toLowerCase()
            .contains(ivaoFlightSearchQuery))
            .toList();
      }

      state = state.copyWith(filteredIvaoFlights: filteredFlights, ivaoFlightsSearchQuery: ivaoFlightSearchQuery);
    }
  }

  Future<void> loadNetworkHistory(int networkId, int pageOffset) async {
    var vatsimHistory = await locator<GetFlightsHistoryUseCase>().call(FlightsHistoryParams(networkId: networkId, pageOffset: pageOffset));
    var vatsimFlightPlanHistory = await locator<GetFlightPlanHistoryUseCase>().call(FlightPlanHistoryParams(vatsimId: networkId));
    var vatsimHours = await locator<GetVatsimUserHoursUseCase>().call(networkId);
    var vatsimAtcHistory = await locator<GetAtcHistoryUseCase>().call(networkId);

    state = state.copyWith(
      vatsimFlightsHistory: vatsimHistory,
      vatsimFlightPlanHistory: vatsimFlightPlanHistory,
      vatsimUserHours: vatsimHours,
      atcHistory: vatsimAtcHistory,
    );
  }

  Future<bool> refreshLiveData() async {
    try {
      var vatsimLiveData = await locator<GetLiveDataUseCase>().call(LiveDataSummaryParams(network: SimNetwork.vatsim));
      var vatsimTransceivers = await locator<GetVatsimTransceiversUseCase>().call('');
      var ivaoLiveData = await locator<GetLiveDataUseCase>().call(LiveDataSummaryParams(network: SimNetwork.ivao));

      var cleanVatsimControllers = _cleanControllerList(vatsimLiveData.controllers);
      var cleanIvaoControllers = _cleanControllerList(ivaoLiveData.controllers);

      state = state.copyWith(
        vatsimFlights: vatsimLiveData.flights,
        vatsimControllers: cleanVatsimControllers,
        vatsimTransceivers: vatsimTransceivers,
        ivaoFlights: ivaoLiveData.flights,
        ivaoControllers: cleanIvaoControllers,
        filteredIvaoControllers: state.ivaoControllersSearchQuery.isNotEmpty ? cleanIvaoControllers.where((controller) => controller.callsign.toLowerCase().contains(state.ivaoControllersSearchQuery.toLowerCase())).toList() : cleanIvaoControllers,
        filteredVatsimControllers: state.vatsimControllersSearchQuery.isNotEmpty ? cleanVatsimControllers.where((controller) => controller.callsign.toLowerCase().contains(state.vatsimControllersSearchQuery.toLowerCase())).toList() : cleanVatsimControllers,
        filteredIvaoFlights: state.ivaoFlightsSearchQuery.isNotEmpty ? ivaoLiveData.flights.where((flight) => flight.callsign.toLowerCase().contains(state.ivaoFlightsSearchQuery.toLowerCase())).toList() : ivaoLiveData.flights,
        filteredVatsimFlights: state.vatsimFlightsSearchQuery.isNotEmpty ? vatsimLiveData.flights.where((flight) => flight.callsign.toLowerCase().contains(state.vatsimFlightsSearchQuery.toLowerCase())).toList() : vatsimLiveData.flights,
      );
    } catch (e) {
      // Handle error
    }

    ref.read(mapProvider.notifier).refreshMapItems();
    return true;
  }

  List<ControllerSummary> _cleanControllerList(List<ControllerSummary> controllers) {
   var allowedControllerCodes =  [
     ControllerType.delivery.code,
     ControllerType.ground.code,
     ControllerType.tower.code,
     ControllerType.approach.code,
     ControllerType.departure.code,
     ControllerType.center.code,
     ControllerType.service.code,
     ControllerType.observer.code,
   ];

   return controllers.where((controller) => allowedControllerCodes.contains(controller.callsign.takeLast(4))).toList();

  }
}