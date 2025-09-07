import 'dart:typed_data';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sim_flights_tracker/core/constants/date_type.dart';
import 'package:sim_flights_tracker/core/constants/sim_network.dart';
import 'package:sim_flights_tracker/core/constants/supported_language.dart';
import 'package:sim_flights_tracker/data/entity/_air_traffic_control_sector.dart';
import 'package:sim_flights_tracker/data/entity/_authed_user_details.dart';
import 'package:sim_flights_tracker/domain/model/airport_extract.dart';

@immutable
class AppConfigState {
  final SimNetwork currentSimNetwork;
  final ConnectivityResult connectivityResult;
  final List<AirportExtract> airports;
  final List<AirTrafficControlSector> airTrafficControlSectors;
  final Locale currentLocale;
  final DateType dateType;
  final String navbarType;
  final String appVersion;
  final String buildNumber;
  final String vatsimId;
  final SupportedLanguage currentLanguage;
  final SharedPreferences? sharedPreferences;
  final bool configLoadedSuccessfully;
  final String mapProjection;
  final bool isLargeScreenDevice;
  final bool isWebviewNavigating;

  final Uint8List? deliveryMarkerImage;
  final Uint8List? groundMarkerImage;
  final Uint8List? towerMarkerImage;
  final Uint8List? planeMarkerImage;
  final bool shouldShowPromos;
  final bool purchaseInProgress;

  final String vatsimAuthenticationId;
  final bool vatsimAuthenticated;
  final bool isAuthenticating;
  final AuthedUserDetails? authedUserDetails;

  const AppConfigState({
    this.currentSimNetwork = SimNetwork.vatsim,
    this.connectivityResult = ConnectivityResult.wifi,
    this.airports = const [],
    this.airTrafficControlSectors = const [],
    this.currentLocale = const Locale('en'),
    this.dateType = DateType.zulu,
    this.navbarType = 'slide',
    this.appVersion = '',
    this.buildNumber = '',
    this.currentLanguage = SupportedLanguage.en,
    this.sharedPreferences,
    this.deliveryMarkerImage,
    this.groundMarkerImage,
    this.towerMarkerImage,
    this.planeMarkerImage,
    this.vatsimId = '',
    this.configLoadedSuccessfully = true,
    this.mapProjection = 'mercator',
    this.isLargeScreenDevice = false,
    this.shouldShowPromos = false,
    this.purchaseInProgress = false,
    this.vatsimAuthenticationId = '',
    this.vatsimAuthenticated = false,
    this.isAuthenticating = false,
    this.authedUserDetails,
    this.isWebviewNavigating = false,
  });

  AppConfigState copyWith({
    SimNetwork? currentSimNetwork,
    ConnectivityResult? connectivityResult,
    List<AirportExtract>? airports,
    List<AirTrafficControlSector>? airTrafficControlSectors,
    Locale? currentLocale,
    DateType? dateType,
    String? navbarType,
    String? appVersion,
    String? buildNumber,
    String? vatsimId,
    SupportedLanguage? currentLanguage,
    SharedPreferences? sharedPreferences,
    Uint8List? deliveryMarkerImage,
    Uint8List? groundMarkerImage,
    Uint8List? towerMarkerImage,
    Uint8List? planeMarkerImage,
    bool? configLoadedSuccessfully,
    String? mapProjection,
    bool? isLargeScreenDevice,
    bool? shouldShowPromos,
    bool? purchaseInProgress,
    String? vatsimAuthenticationId,
    bool? vatsimAuthenticated,
    bool? isAuthenticating,
    AuthedUserDetails? authedUserDetails,
    bool? isWebviewNavigating,
  }) {
    return AppConfigState(
      currentSimNetwork: currentSimNetwork ?? this.currentSimNetwork,
      connectivityResult: connectivityResult ?? this.connectivityResult,
      airports: airports ?? this.airports,
      airTrafficControlSectors: airTrafficControlSectors ?? this.airTrafficControlSectors,
      currentLanguage: currentLanguage ?? this.currentLanguage,
      dateType: dateType ?? this.dateType,
      navbarType: navbarType ?? this.navbarType,
      currentLocale: currentLocale ?? this.currentLocale,
      appVersion: appVersion ?? this.appVersion,
      buildNumber: buildNumber ?? this.buildNumber,
      vatsimId: vatsimId ?? this.vatsimId,
      sharedPreferences: sharedPreferences ?? this.sharedPreferences,
      deliveryMarkerImage: deliveryMarkerImage ?? this.deliveryMarkerImage,
      groundMarkerImage: groundMarkerImage ?? this.groundMarkerImage,
      towerMarkerImage: towerMarkerImage ?? this.towerMarkerImage,
      planeMarkerImage: planeMarkerImage ?? this.planeMarkerImage,
      configLoadedSuccessfully: configLoadedSuccessfully ?? this.configLoadedSuccessfully,
      mapProjection: mapProjection ?? this.mapProjection,
      isLargeScreenDevice: isLargeScreenDevice ?? this.isLargeScreenDevice,
      shouldShowPromos: shouldShowPromos ?? this.shouldShowPromos,
      purchaseInProgress: purchaseInProgress ?? this.purchaseInProgress,
      vatsimAuthenticationId: vatsimAuthenticationId ?? this.vatsimAuthenticationId,
      vatsimAuthenticated: vatsimAuthenticated ?? this.vatsimAuthenticated,
      isAuthenticating: isAuthenticating ?? this.isAuthenticating,
      authedUserDetails: authedUserDetails ?? this.authedUserDetails,
      isWebviewNavigating: isWebviewNavigating ?? this.isWebviewNavigating
    );
  }
}