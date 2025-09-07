import 'package:flutter/material.dart';
import 'package:sim_flights_tracker/data/entity/_atc_history.dart';
import 'package:sim_flights_tracker/data/entity/_controller_summary.dart';
import 'package:sim_flights_tracker/data/entity/_flight_summary.dart';
import 'package:sim_flights_tracker/data/entity/_vatsim_transceiver.dart';
import 'package:sim_flights_tracker/data/entity/_vatsim_user_hours.dart';

import '../../../data/entity/_flight_plan_history_item.dart';
import '../../../data/entity/_flights_history.dart';

@immutable
class LiveDataState {
  final List<FlightSummary> vatsimFlights;
  final List<ControllerSummary> vatsimControllers;
  final List<VatsimTransceiver> vatsimTransceivers;
  final List<FlightSummary> ivaoFlights;
  final List<ControllerSummary> ivaoControllers;

  final List<ControllerSummary>  filteredVatsimControllers;
  final List<ControllerSummary>  filteredIvaoControllers;
  final String vatsimControllersSearchQuery;
  final String ivaoControllersSearchQuery;

  final List<FlightSummary> filteredVatsimFlights;
  final List<FlightSummary> filteredIvaoFlights;
  final String vatsimFlightsSearchQuery;
  final String ivaoFlightsSearchQuery;

  final FlightsHistory vatsimFlightsHistory;
  final List<FlightPlanHistoryItem> vatsimFlightPlanHistory;
  final VatsimUserHours? vatsimUserHours;
  final AtcHistory atcHistory;

  const LiveDataState({
    this.vatsimFlights = const [],
    this.vatsimControllers = const [],
    this.vatsimTransceivers = const [],
    this.ivaoFlights = const [],
    this.ivaoControllers = const [],
    this.filteredVatsimControllers = const [],
    this.filteredIvaoControllers = const [],
    this.vatsimControllersSearchQuery = '',
    this.ivaoControllersSearchQuery = '',
    this.filteredVatsimFlights = const [],
    this.filteredIvaoFlights = const [],
    this.vatsimFlightsSearchQuery = '',
    this.ivaoFlightsSearchQuery = '',
    this.vatsimFlightsHistory = const FlightsHistory(0, []),
    this.vatsimFlightPlanHistory = const [],
    this.vatsimUserHours,
    this.atcHistory = const AtcHistory([], 0),
  });

  LiveDataState  copyWith({
    List<FlightSummary>? vatsimFlights,
    List<ControllerSummary>? vatsimControllers,
    List<VatsimTransceiver>? vatsimTransceivers,
    List<FlightSummary>? ivaoFlights,
    List<ControllerSummary>? ivaoControllers,
    List<ControllerSummary>? filteredVatsimControllers,
    List<ControllerSummary>? filteredIvaoControllers,
    String? vatsimControllersSearchQuery,
    String? ivaoControllersSearchQuery,
    List<FlightSummary>? filteredVatsimFlights,
    List<FlightSummary>? filteredIvaoFlights,
    String? vatsimFlightsSearchQuery,
    String? ivaoFlightsSearchQuery,
    FlightsHistory? vatsimFlightsHistory,
    List<FlightPlanHistoryItem>? vatsimFlightPlanHistory,
    VatsimUserHours? vatsimUserHours,
    AtcHistory? atcHistory,
  }) {
    return LiveDataState(
      vatsimFlights: vatsimFlights ?? this.vatsimFlights,
      vatsimControllers: vatsimControllers ?? this.vatsimControllers,
      vatsimTransceivers: vatsimTransceivers ?? this.vatsimTransceivers,
      ivaoFlights: ivaoFlights ?? this.ivaoFlights,
      ivaoControllers: ivaoControllers ?? this.ivaoControllers,
      filteredVatsimControllers: filteredVatsimControllers ?? this.filteredVatsimControllers,
      filteredIvaoControllers: filteredIvaoControllers ?? this.filteredIvaoControllers,
      vatsimControllersSearchQuery: vatsimControllersSearchQuery ?? this.vatsimControllersSearchQuery,
      ivaoControllersSearchQuery: ivaoControllersSearchQuery ?? this.ivaoControllersSearchQuery,
      filteredVatsimFlights: filteredVatsimFlights ?? this.filteredVatsimFlights,
      filteredIvaoFlights: filteredIvaoFlights ?? this.filteredIvaoFlights,
      vatsimFlightsSearchQuery: vatsimFlightsSearchQuery ?? this.vatsimFlightsSearchQuery,
      ivaoFlightsSearchQuery: ivaoFlightsSearchQuery ?? this.ivaoFlightsSearchQuery,
      vatsimFlightsHistory: vatsimFlightsHistory ?? this.vatsimFlightsHistory,
      vatsimFlightPlanHistory: vatsimFlightPlanHistory ?? this.vatsimFlightPlanHistory,
      vatsimUserHours: vatsimUserHours ?? this.vatsimUserHours,
      atcHistory: atcHistory ?? this.atcHistory,
    );
  }
}