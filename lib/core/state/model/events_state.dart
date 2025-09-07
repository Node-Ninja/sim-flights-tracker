import 'package:flutter/material.dart';
import 'package:sim_flights_tracker/data/entity/_sft_event_summary.dart';

@immutable
class EventsState {
  final List<SftEventSummary> allVatsimEvents;
  final List<SftEventSummary> allIvaoEvents;
  final List<SftEventSummary> filteredVatsimEvents;
  final List<SftEventSummary> filteredIvaoEvents;

  const EventsState({
    this.allVatsimEvents = const [],
    this.allIvaoEvents = const [],
    this.filteredVatsimEvents = const [],
    this.filteredIvaoEvents = const [],
  });

  EventsState copyWith({
    List<SftEventSummary>? allVatsimEvents,
    List<SftEventSummary>? allIvaoEvents,
    List<SftEventSummary>? filteredVatsimEvents,
    List<SftEventSummary>? filteredIvaoEvents,
  }) {
    return EventsState(
      allVatsimEvents: allVatsimEvents ?? this.allVatsimEvents,
      allIvaoEvents: allIvaoEvents ?? this.allVatsimEvents,
      filteredIvaoEvents: filteredIvaoEvents ?? this.filteredIvaoEvents,
      filteredVatsimEvents: filteredVatsimEvents ?? this.filteredVatsimEvents,
    );
  }

}