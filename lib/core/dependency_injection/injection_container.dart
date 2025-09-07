import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sim_flights_tracker/data/datasource/remote/sft/sft_datasource.dart';
import 'package:sim_flights_tracker/data/datasource/remote/sft/sft_datasource_impl.dart';
import 'package:sim_flights_tracker/data/repository/aircraft_repository_impl.dart';
import 'package:sim_flights_tracker/data/repository/airlines_repository_impl.dart';
import 'package:sim_flights_tracker/data/repository/airports_repository_impl.dart';
import 'package:sim_flights_tracker/data/repository/auth_repository_impl.dart';
import 'package:sim_flights_tracker/data/repository/controllers_repository_impl.dart';
import 'package:sim_flights_tracker/data/repository/events_repository_impl.dart';
import 'package:sim_flights_tracker/data/repository/flights_repository_impl.dart';
import 'package:sim_flights_tracker/domain/repository/aircraft_repository.dart';
import 'package:sim_flights_tracker/domain/repository/airlines_repository.dart';
import 'package:sim_flights_tracker/domain/repository/airports_repository.dart';
import 'package:sim_flights_tracker/domain/repository/auth_repository.dart';
import 'package:sim_flights_tracker/domain/repository/controllers_repository.dart';
import 'package:sim_flights_tracker/domain/repository/events_repository.dart';
import 'package:sim_flights_tracker/domain/repository/flights_repository.dart';
import 'package:sim_flights_tracker/domain/usecase/airlines/get_airline.dart';
import 'package:sim_flights_tracker/domain/usecase/airports/get_airport.dart';
import 'package:sim_flights_tracker/domain/usecase/airports/get_airport_metar.dart';
import 'package:sim_flights_tracker/domain/usecase/controllers/get_controller_details.dart';
import 'package:sim_flights_tracker/domain/usecase/controllers/get_vatsim_transceivers.dart';
import 'package:sim_flights_tracker/domain/usecase/events/get_event_details.dart';
import 'package:sim_flights_tracker/domain/usecase/events/get_events.dart';
import 'package:sim_flights_tracker/domain/usecase/auth/get_authed_user_details.dart';
import 'package:sim_flights_tracker/domain/usecase/flights/get_flight_details.dart';
import 'package:sim_flights_tracker/domain/usecase/flights/get_flight_plan_history.dart';
import 'package:sim_flights_tracker/domain/usecase/flights/get_flight_track.dart';
import 'package:sim_flights_tracker/domain/usecase/flights/get_flights_history.dart';
import 'package:sim_flights_tracker/domain/usecase/flights/get_live_data.dart';
import 'package:sim_flights_tracker/domain/usecase/auth/get_start_auth.dart';
import 'package:sim_flights_tracker/domain/usecase/flights/get_vatsim_user_hours.dart';
import 'package:sim_flights_tracker/domain/usecase/auth/vatsim_logout.dart';
import 'package:sim_flights_tracker/domain/usecase/history/get_atc_history.dart';

import '../../domain/usecase/aircraft/get_aircraft_details.dart';
import '../../domain/usecase/airports/search_airports.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  locator.registerSingleton(Dio());

  //  data sources;
  locator.registerLazySingleton<SftDatasource>(() => SftDatasourceImpl(locator()));

  //  repositories
  locator.registerLazySingleton<FlightsRepository>(() => FlightsRepositoryImpl(locator()));
  locator.registerLazySingleton<AirportsRepository>(() => AirportsRepositoryImpl(locator()));
  locator.registerLazySingleton<AirlinesRepository>(() => AirlinesRepositoryImpl(locator()));
  locator.registerLazySingleton<EventsRepository>(() => EventsRepositoryImpl(locator()));
  locator.registerLazySingleton<AircraftRepository>(() => AircraftRepositoryImpl(locator()));
  locator.registerLazySingleton<ControllersRepository>(() => ControllersRepositoryImpl(locator()));
  locator.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(locator()));

  //  use cases
  locator.registerLazySingleton<GetFlightDetailsUseCase>(() => GetFlightDetailsUseCase(locator()));
  locator.registerLazySingleton<GetLiveDataUseCase>(() => GetLiveDataUseCase(locator()));
  locator.registerLazySingleton<GetAirlineUseCase>(() => GetAirlineUseCase(locator()));
  locator.registerLazySingleton<GetAirportUseCase>(() => GetAirportUseCase(locator()));
  locator.registerLazySingleton<SearchAirportsUseCase>(() => SearchAirportsUseCase(locator()));
  locator.registerLazySingleton<GetAirportMetarUseCase>(() => GetAirportMetarUseCase(locator()));
  locator.registerLazySingleton<GetEventsUseCase>(() => GetEventsUseCase(locator()));
  locator.registerLazySingleton<GetEventDetailsUseCase>(() => GetEventDetailsUseCase(locator()));
  locator.registerLazySingleton<GetVatsimTransceiversUseCase>(() => GetVatsimTransceiversUseCase(locator()));
  locator.registerLazySingleton<GetAircraftDetailsUseCase>(() => GetAircraftDetailsUseCase(locator()));
  locator.registerLazySingleton<GetControllerDetailsUseCase>(() => GetControllerDetailsUseCase(locator()));
  locator.registerLazySingleton<GetFlightsHistoryUseCase>(() => GetFlightsHistoryUseCase(locator()));
  locator.registerLazySingleton<GetFlightPlanHistoryUseCase>(() => GetFlightPlanHistoryUseCase(locator()));
  locator.registerLazySingleton<GetFlightTrackUseCase>(() => GetFlightTrackUseCase(locator()));
  locator.registerLazySingleton<GetVatsimUserHoursUseCase>(() => GetVatsimUserHoursUseCase(locator()));
  locator.registerLazySingleton<GetStartAuthUseCase>(() => GetStartAuthUseCase(locator()));
  locator.registerLazySingleton<GetAuthedUserDetailsUseCase>(() => GetAuthedUserDetailsUseCase(locator()));
  locator.registerLazySingleton<VatsimLogoutUseCase>(() => VatsimLogoutUseCase(locator()));
  locator.registerLazySingleton<GetAtcHistoryUseCase>(() => GetAtcHistoryUseCase(locator()));
}