import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/usecase/airports/search_airports.dart';
import '../../dependency_injection/injection_container.dart';
import '../model/airports_state.dart';

class AirportsStateNotifier extends AsyncNotifier<AirportsState> {

  @override
  AirportsState build() => const AirportsState();

  Future<void> searchAirport(String query) async {
    //  check and set state defaults if query is empty'
    if (query == '' || query.length < 4) {
      state = const AsyncValue.data(AirportsState());

      return;
    }

    //  set state value to loading, until data is available;
    state = const AsyncValue.loading();

    try {
      var airportsSearchResponse = await locator<SearchAirportsUseCase>().call(SearchAirportsParams(query: query));

      state = AsyncValue.data(AirportsState(
        matchingAirports: airportsSearchResponse
      ));

    } catch (e, trace) {
      state = AsyncValue.error('Failed to get airports', trace);
    }
  }

}