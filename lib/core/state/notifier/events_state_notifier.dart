import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/sim_network.dart';
import '../../../data/entity/_sft_event_summary.dart';
import '../../../domain/usecase/events/get_events.dart';
import '../../dependency_injection/injection_container.dart';
import '../model/events_state.dart';

class EventsStateNotifier extends AsyncNotifier<EventsState> {

  @override
  EventsState build() => const EventsState();

  Future<void> loadAllEvents() async {
    List<SftEventSummary> filteredVatsimEvents = [];
    List<SftEventSummary> filteredIvaoEvents = [];

    try {
      var vatsimEvents = await locator<GetEventsUseCase>().call(EventsListParams(network: SimNetwork.vatsim));
      var ivaoEvents = await locator<GetEventsUseCase>().call(EventsListParams(network: SimNetwork.ivao));


      filteredVatsimEvents = vatsimEvents.where((event) {
        var eventDate = event.startTime.toLocal();
        var selectedDate = DateTime.now().toLocal();

        return _isEventWithinDate(eventDate, selectedDate);
      }).toList();



      filteredIvaoEvents = ivaoEvents.where((event) {
        var eventDate = event.startTime.toLocal();
        var selectedDate = DateTime.now().toLocal();

        return _isEventWithinDate(eventDate, selectedDate);
      }).toList();

      state = AsyncValue.data(EventsState(
        allIvaoEvents: ivaoEvents,
        allVatsimEvents: vatsimEvents,
        filteredIvaoEvents: filteredIvaoEvents,
        filteredVatsimEvents: filteredVatsimEvents,
      ));

    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  void filterByDate(DateTime dateTime, [SimNetwork simNetwork = SimNetwork.vatsim, bool shouldNotify = true]) {
    List<SftEventSummary> filteredEvents = [];
    List<SftEventSummary> filteredVatsimEvents = [];
    List<SftEventSummary> filteredIvaoEvents = [];

    if (state.hasValue) {
      var eventsToFilter = simNetwork == SimNetwork.vatsim
          ?  state.value?.allVatsimEvents ?? []
          : state.value?.allIvaoEvents ?? [];

      filteredEvents = eventsToFilter.where((event) {
        var eventDate = event.startTime.toLocal();
        var selectedDate = dateTime.toLocal();

        return _isEventWithinDate(eventDate, selectedDate);
      }).toList();

      simNetwork == SimNetwork.vatsim
          ? filteredVatsimEvents = filteredEvents
          : filteredIvaoEvents = filteredEvents;

      state = AsyncValue.data(EventsState(
        allIvaoEvents: state.value?.allIvaoEvents ?? [],
        allVatsimEvents: state.value?.allVatsimEvents ?? [],
        filteredIvaoEvents: filteredIvaoEvents,
        filteredVatsimEvents: filteredVatsimEvents,
      ));
    }
  }

  void clearFiltered() {
    state = AsyncValue.data(EventsState(
      allIvaoEvents: state.value?.allIvaoEvents ?? [],
      allVatsimEvents: state.value?.allVatsimEvents ?? [],
      filteredIvaoEvents: [],
      filteredVatsimEvents: [],
    ));
  }

  bool _isEventWithinDate(DateTime eventDate, DateTime selectedDate) {

    var eDate = DateTime(eventDate.year, eventDate.month, eventDate.day);
    var sDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

    return eDate == sDate;
  }
}