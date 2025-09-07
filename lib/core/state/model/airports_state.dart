import 'package:flutter/material.dart';
import 'package:sim_flights_tracker/data/entity/_airport.dart';

@immutable
class AirportsState {
  final String errorMessage;
  final List<Airport> matchingAirports;

  const AirportsState({
    this.errorMessage = '',
    this.matchingAirports = const [],
  });

  AirportsState copyWith({
    String? errorMessage,
    List<Airport>? matchingAirports,
  }) {
    return AirportsState(
      errorMessage: errorMessage ?? this.errorMessage,
      matchingAirports: matchingAirports ?? this.matchingAirports,
    );
  }
}