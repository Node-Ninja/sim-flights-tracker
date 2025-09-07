

import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sim_flights_tracker/core/constants/date_type.dart';
import 'package:sim_flights_tracker/core/constants/sim_network.dart';
import 'package:sim_flights_tracker/core/constants/supported_language.dart';
import 'package:sim_flights_tracker/core/state/provider/providers.dart';

void main() {
  test('AppConfigProvider :: Date type', () {
    final container = ProviderContainer();

    expect(container.read(appConfigProvider).dateType, isA<DateType>(), reason: 'Validate that DateType is of type DateType');
    expect(container.read(appConfigProvider).dateType, equals(DateType.zulu), reason: 'Check default date type');
  });

  test('AppConfigProvider :: Check VATSIM is authenticated default value', () {
    final container = ProviderContainer();

    expect(container.read(appConfigProvider).vatsimAuthenticated, isA<bool>(), reason: 'Validate that vatsimIsAuthenticated is of type bool');
    expect(container.read(appConfigProvider).vatsimAuthenticated, equals(false), reason: 'Check default value');
  });

  test('AppConfigProvider :: Check state update methods', () {
    final container = ProviderContainer();

    container.read(appConfigProvider.notifier).updateDateType(DateType.local);
    container.read(appConfigProvider.notifier).updateSimNetwork(SimNetwork.ivao);
    container.read(appConfigProvider.notifier).updateVatsimId('TestID');
    container.read(appConfigProvider.notifier).updateLocale(SupportedLanguage.tn);
    container.read(appConfigProvider.notifier).updateMapProjection('RandomProjection');
    container.read(appConfigProvider.notifier).updatePurchaseInProgress(true);
    container.read(appConfigProvider.notifier).updateAuthLoading(true);
    container.read(appConfigProvider.notifier).updateAuthId('TestAuthID');
    container.read(appConfigProvider.notifier).updateVatsimAuthenticated(true);

    expect(container.read(appConfigProvider).dateType, equals(DateType.local));
    expect(container.read(appConfigProvider).currentSimNetwork, equals(SimNetwork.ivao));
    expect(container.read(appConfigProvider).vatsimId, equals('TestID'));
    expect(container.read(appConfigProvider).currentLocale, equals(Locale(SupportedLanguage.tn.name)));
    expect(container.read(appConfigProvider).mapProjection, equals('RandomProjection'));
    expect(container.read(appConfigProvider).purchaseInProgress, equals(true));
    expect(container.read(appConfigProvider).isAuthenticating, equals(true));
    expect(container.read(appConfigProvider).vatsimAuthenticationId, equals('TestAuthID'));
    expect(container.read(appConfigProvider).vatsimAuthenticated, equals(true));
  });
}