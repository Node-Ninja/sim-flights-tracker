import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/ads_state.dart';
import '../model/airports_state.dart';
import '../model/app_config_state.dart';
import '../model/events_state.dart';
import '../model/live_data_state.dart';
import '../model/map_state.dart';
import '../model/notifications_state.dart';
import '../notifier/ads_state_notifier.dart';
import '../notifier/airports_state_notifier.dart';
import '../notifier/app_config_state_notifier.dart';
import '../notifier/events_state_notifier.dart';
import '../notifier/live_data_state_notifier.dart';
import '../notifier/map_state_notifier.dart';
import '../notifier/notifications_state_notifier.dart';

final airportsProvider = AsyncNotifierProvider<AirportsStateNotifier, AirportsState>(() => AirportsStateNotifier());
final eventsProvider = AsyncNotifierProvider<EventsStateNotifier, EventsState>(() => EventsStateNotifier());
final liveDataProvider = NotifierProvider<LiveDataStateNotifier, LiveDataState>(() => LiveDataStateNotifier());
final adsProvider = AsyncNotifierProvider<AdsStateNotifier, AdsState>(() => AdsStateNotifier());
final appConfigProvider = NotifierProvider<AppConfigStateNotifier, AppConfigState>(() => AppConfigStateNotifier());
final mapProvider = NotifierProvider<MapStateNotifier, MapState>(() => MapStateNotifier());
final notificationsProvider = NotifierProvider<NotificationsStateNotifier, NotificationsState>(() => NotificationsStateNotifier());