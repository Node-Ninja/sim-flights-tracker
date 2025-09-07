import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sim_flights_tracker/core/constants/backend_host.dart';
import 'package:sim_flights_tracker/core/constants/sim_network.dart';
import 'package:sim_flights_tracker/core/exceptions/remote_datasource_exception.dart';
import 'package:sim_flights_tracker/data/datasource/remote/sft/sft_datasource.dart';
import 'package:sim_flights_tracker/data/entity/_aircraft.dart';
import 'package:sim_flights_tracker/data/entity/_airline.dart';
import 'package:sim_flights_tracker/data/entity/_airport.dart';
import 'package:sim_flights_tracker/data/entity/_atc_history.dart';
import 'package:sim_flights_tracker/data/entity/_authed_user_details.dart';
import 'package:sim_flights_tracker/data/entity/_controller.dart';
import 'package:sim_flights_tracker/data/entity/_data_summary.dart';
import 'package:sim_flights_tracker/data/entity/_flight.dart';
import 'package:sim_flights_tracker/data/entity/_flight_track.dart';
import 'package:sim_flights_tracker/data/entity/_flights_history.dart';
import 'package:sim_flights_tracker/data/entity/_sft_event.dart';
import 'package:sim_flights_tracker/data/entity/_sft_event_summary.dart';
import 'package:sim_flights_tracker/data/entity/_vatsim_transceiver.dart';
import 'package:sim_flights_tracker/data/entity/_vatsim_user_hours.dart';

import '../../../entity/_flight_plan_history_item.dart';

class SftDatasourceImpl implements SftDatasource {
  final Dio _http;

  SftDatasourceImpl(this._http);

  final String _apiHost = dotenv.get('SFT_SERVER_URL');

  @override
  Future<DataSummary> getLiveDataSummary(SimNetwork network) async {
    try {
      final res = await _http.post('$_apiHost/api/v2/${network.name}/live-data');

      if (res.statusCode == HttpStatus.ok) {
        return DataSummary.fromJson(res.data);
      }

      throw RemoteDatasourceException('Unable to get live data for $network');
    } catch (e) {
      return DataSummary([], []);
    }
  }

  @override
  Future<Flight?> getFlightDetails(String callsign, SimNetwork network) async {
    try {
      final res = await _http.post('$_apiHost/api/v2/${network.name}/flights/$callsign');

      if (res.statusCode == HttpStatus.ok) {
        if (res.data == 'null' || res.data == null) {
          return null;
        }

        return Flight.fromJson(res.data);
      }

      throw RemoteDatasourceException('Unable to get flight details for $callsign');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Airport>> searchAirports(String query) async {
    var endpoint = '$_apiHost/api/v2/airport/$query';

    try {
      final res = await _http.post(endpoint);

      if (res.statusCode == 200) {
        var body = res.data;
        var airportList = List<Airport>.from(body.map((airportMap) => Airport.fromJson(airportMap)));

        return airportList;
      }

      throw 'Something went wrong';
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> getAirportMetar(String icaoId) async {
    String metar = 'No metar available for this airport.';

    try {
      final res = await _http.post('$_apiHost/api/v2/vatsim/metar/$icaoId');

      if (res.statusCode == 200 && res.data != '') {
        metar = res.data;
      }
    } catch (e) {
      metar = 'No metar available for this airport.';
    }

    return metar;
  }

  @override
  Future<Aircraft?> getAircraft(String icaoId) async {
    Aircraft? aircraft;

    final res = await _http.get('$_apiHost/api/v2/aircraft/$icaoId');

    if (res.statusCode == HttpStatus.ok && res.data != 'null') {
      aircraft = Aircraft.fromJson(res.data);
    }

    return aircraft;
  }

  @override
  Future<SftEvent?> getEventDetails(int eventId, SimNetwork simNetwork) async {
    SftEvent event;

    try {
      var res = await _http.post('$_apiHost/api/v2/${simNetwork.name}/events/$eventId');

      if (res.statusCode == 200) {
        var body = res.data;
        event = SftEvent.fromJson(body);

        return event;
      }

      throw 'Invalid response received';
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<SftEventSummary>> getEvents(SimNetwork network) async {
    var events = <SftEventSummary>[];

    try {
      var res = await _http.post('$_apiHost/api/v2/${network.name}/events');

      if (res.statusCode == 200) {
        var body = res.data;
        events = List<SftEventSummary>.from(body.map((object) => SftEventSummary.fromJson(object)));

        return events;
      }

      throw 'Invalid response received';
    } catch (e) {
      return events;
    }
  }

  @override
  Future<List<VatsimTransceiver>> getVatsimTransceivers() async {
    var transceivers = <VatsimTransceiver>[];

    try {
      var res = await _http.post('$_apiHost/api/v2/vatsim/transceivers');

      if (res.statusCode == HttpStatus.ok) {
        var body = res.data;
        transceivers = List<VatsimTransceiver>.from(body.map((object) => VatsimTransceiver.fromJson(object)));

        return transceivers;
      }

      throw 'Something went wrong trying to get transceivers';
    } catch (e) {
      return transceivers;
    }
  }

  @override
  Future<Airport?> getAirport({String icaoId = 'invalid'}) async {
    Airport? airport;

    try {
      final res = await _http.get('$_apiHost/api/v2/airport/$icaoId');

      if (res.data != 'null' && res.data != null) {
        airport = Airport.fromJson(res.data);
      }
    } catch (e) {
      //  todo: handle properly
    }

    return airport;
  }

  @override
  Future<Airline?> getAirline(String icaoId) async {
    Airline? airline;

    try {
      final res = await _http.get('$_apiHost/api/v2/airline/$icaoId');

      if (res.statusCode == HttpStatus.ok && res.data != 'null') {
        airline = Airline.fromJson(res.data);
      }
    } catch (e) {
      //  Implement handler;
    }

    return airline;
  }

  @override
  Future<Controller?> getControllerDetails(String callsign, SimNetwork network) async {
    try {
      final res = await _http.post('$_apiHost/api/v2/${network.name}/atc/$callsign');

      if (res.statusCode == HttpStatus.ok) {
        if (res.data == 'null' || res.data == null || res.data == '') {
          return null;
        }

        return Controller.fromJson(res.data);
      }

      throw 'Something went wrong trying to get flight details';
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<FlightsHistory> getVatsimFlightsHistory(int vatsimId, int pageOffset) async {
    try {
      final res = await _http.post('$_apiHost/api/v2/vatsim/history/flights/$vatsimId/$pageOffset');

      if (res.statusCode == HttpStatus.ok) {
        return FlightsHistory.fromJson(res.data);
      }

      throw 'Something went wrong trying to get flight details';
    } catch (e) {
      return Future.value(FlightsHistory(0, []));
    }
  }

  @override
  Future<List<FlightPlanHistoryItem>> getVatsimFlightPlanHistory(int vatsimId) async {
    try {
      final res = await _http.post('$_apiHost/api/v2/vatsim/history/plans/$vatsimId');

      if (res.statusCode == HttpStatus.ok) {
        var body = res.data;
        var historyList = List<FlightPlanHistoryItem>.from(
          body.map((object) => FlightPlanHistoryItem.fromJson(object)),
        );

        return historyList;
      }

      throw 'Something went wrong trying to get flight details';
    } catch (e) {
      return Future.value([]);
    }
  }

  @override
  Future<FlightTrack> getFlightTrack(String callsign, SimNetwork network) async {
    try {
      final res = await _http.post('$_apiHost/api/v2/${network.name}/flights/$callsign/track');

      if (res.statusCode == HttpStatus.ok && res.data != null) {
        var body = res.data;
        var trackData = FlightTrack.fromJson(body);

        return trackData;
      }

      throw 'Something went wrong trying to get flight track';
    } catch (e) {
      return Future.value(FlightTrack(callsign, []));
    }
  }

  @override
  Future<VatsimUserHours?> getVatsimUserHours(int vatsimId) async {
    try {
      final res = await _http.post('$_apiHost/api/v2/vatsim/history/hours/$vatsimId');

      if (res.statusCode == HttpStatus.ok && res.data != null) {
        var body = res.data;
        var hoursData = VatsimUserHours.fromJson(body);

        return hoursData;
      }

      throw 'Something went wrong trying to get vatsim user hours stats';
    } catch (e) {
      return null;
    }
  }
  
  @override
  Future<String?> startVatsimAuth() async {
    try {
      final res = await _http.post('$_apiHost/api/v2/vatsim/auth/start'); 

      if (res.statusCode == HttpStatus.ok && res.data != null) {
        return res.data;
      }

      throw 'Something went wrong trying to start Vatsim authentication';
    } catch (e) {
      return null;
    }
  }

  @override
  Future<AuthedUserDetails?> getAuthedUserDetails(String authId) async {
    try {
      final res = await _http.post('$_apiHost/api/v2/vatsim/user/details/$authId');

      if (res.statusCode == HttpStatus.ok && res.data != null) {
        return AuthedUserDetails.fromJson(res.data);
      }

      throw 'Something went wrong trying to get authed user details';
    } catch (e) {
      return Future.value(null);
    }
  }

  @override
  Future<String> vatsimLogout(String authId) async {
    try {
      await _http.post('$_apiHost/api/v2/vatsim/user/logout/$authId');

      return 'OK';
    } catch (e) {
      return 'FAILED';
    }
  }

  @override
  Future<AtcHistory> getVatsimAtcHistory(int vatsimId) async {
    try {
      final res = await _http.post('$_apiHost/api/v2/vatsim/history/atc/$vatsimId');

      if (res.statusCode == HttpStatus.ok) {
        return AtcHistory.fromJson(res.data);
      }

      throw 'Something went wrong trying to get flight details';
    } catch (e) {
      return Future.value(AtcHistory([], 0));
    }
  }
}
