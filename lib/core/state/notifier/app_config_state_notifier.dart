import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';
import 'dart:ui' show PlatformDispatcher;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_cache_hive_store/http_cache_hive_store.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sim_flights_tracker/core/config/router_config.dart';
import 'package:sim_flights_tracker/core/constants/app_routes.dart';
import 'package:sim_flights_tracker/core/constants/sim_network.dart';
import 'package:sim_flights_tracker/core/constants/storage_keys.dart';
import 'package:sim_flights_tracker/core/constants/supported_language.dart';
import 'package:sim_flights_tracker/core/dependency_injection/injection_container.dart';
import 'package:sim_flights_tracker/core/extensions/enum_extensions.dart';
import 'package:sim_flights_tracker/core/interceptors/app_check_interceptor.dart';
import 'package:sim_flights_tracker/core/isolates/callbacks.dart';
import 'package:sim_flights_tracker/core/state/provider/providers.dart';
import 'package:sim_flights_tracker/data/entity/_air_traffic_control_sector.dart';
import 'package:sim_flights_tracker/domain/usecase/auth/get_authed_user_details.dart';
import 'package:sim_flights_tracker/domain/usecase/auth/get_start_auth.dart';
import 'package:sim_flights_tracker/domain/usecase/auth/vatsim_logout.dart';
import 'package:sim_flights_tracker/presentation/util/general_utils.dart';

import '../../../domain/model/airport_extract.dart';
import '../../constants/date_type.dart';
import '../../utils.dart';
import '../model/app_config_state.dart';

class AppConfigStateNotifier extends Notifier<AppConfigState> {
  @override
  AppConfigState build() => AppConfigState();

  void updateNavbarType(String navbarType) {
    _persistNavbarType(navbarType);
    state = state.copyWith(navbarType: navbarType);
  }

  void updateSimNetwork(SimNetwork simNetwork) {
    _persistSimNetwork(simNetwork);
    state = state.copyWith(currentSimNetwork: simNetwork);
  }

  void updateVatsimId(String vatsimId) {
    _persistVatsimId(vatsimId);
    state = state.copyWith(vatsimId: vatsimId);
  }

  void updateLocale(SupportedLanguage language) {
    var locale = Locale(language.name);

    _persistLocale(language.name);
    state = state.copyWith(
      currentLocale: locale,
      currentLanguage: language
    );
  }

  void updateDateType(DateType dateType) {
    _persistDateType(dateType.name);
    state = state.copyWith(dateType: dateType);
  }

  void updateMapProjection(String mapProjection) {
    _persistMapProjection(mapProjection);
    state = state.copyWith(mapProjection: mapProjection);
  }

  void updatePurchaseInProgress(bool purchaseInProgress) {
    state = state.copyWith(purchaseInProgress: purchaseInProgress);
  }

  void updateAuthLoading(bool isAuthenticating) {
    state = state.copyWith(isAuthenticating: isAuthenticating);
  }

  void updateAuthId(String authId) {
    _persistAuthId(authId);
    state = state.copyWith(vatsimAuthenticationId: authId);
  }

  void updateVatsimAuthenticated(bool isAuthenticated) {
    _persistIsAuthenticated(isAuthenticated.toString());
    state = state.copyWith(vatsimAuthenticated: isAuthenticated);
  }

  //  Private config methods to initiate required app config
  Future<void> _initDioClient() async {
    var appDirectory = await getApplicationDocumentsDirectory();

    locator<Dio>().interceptors.add(DioCacheInterceptor(options: CacheOptions(
      store: HiveCacheStore(appDirectory.path),
      policy: CachePolicy.forceCache,
      maxStale: const Duration(days: 90),
      allowPostMethod: false,
    )));

    locator<Dio>().interceptors.add(AppCheckInterceptor());
  }

  Future<void> _initFirebaseRemoteConfig() async {
    await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 12),
    ));

    FirebaseRemoteConfig.instance.fetchAndActivate();
    FirebaseRemoteConfig.instance.onConfigUpdated.listen((e) async {
      await FirebaseRemoteConfig.instance.activate();
    });
  }

  Future<ConnectivityResult> _fetchConnectivityResultAndMonitor() async {
    final Connectivity connectivity = Connectivity();

    List<ConnectivityResult> connectivityResults = await connectivity.checkConnectivity();

    connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      state = state.copyWith(connectivityResult: results.first);
    });

    return connectivityResults.first;
  }

  Future<({Uint8List delivery, Uint8List ground, Uint8List tower, Uint8List plane})> _fetchMapMarkerImages() async {
    var deliveryMarkerImage = await getBytesFromAsset('assets/images/markers/del.png', 10);
    var groundMarkerImage = await getBytesFromAsset('assets/images/markers/gnd.png', 10);
    var towerMarkerImage = await getBytesFromAsset('assets/images/markers/twr.png', 10);
    var planeMarkerImage = await getBytesFromAsset('assets/images/plane_icon_orange.png', 40);

    return (
      delivery: deliveryMarkerImage,
      ground: groundMarkerImage,
      tower: towerMarkerImage,
      plane: planeMarkerImage,
    );
  }

  Future<List<AirportExtract>> _fetchAirportData() async {
    try {
      String data = await rootBundle.loadString('assets/data/simflightstracker.airports.json');
      final jsonData = json.decode(data);
      List<AirportExtract> allAirports = List<AirportExtract>.from(jsonData.map((ap) => AirportExtract.fromJson(ap)));

      return allAirports;
    } catch (e) {
      return [];
    }
  }

  Future<List<AirTrafficControlSector>> _fetchAirTrafficControlSectors() async {
    try {
      String data = await rootBundle.loadString('assets/data/firs.geojson.json');
      List<AirTrafficControlSector> allSectors = await Isolate.run(() => IsolateCallbacks.getAirTrafficControlSectors(data), debugName: 'LoadSectorsFromFile');

      return allSectors;
    } catch (e) {
      return [];
    }
  }

  void _persistLocale(String localeName) {
    state.sharedPreferences?.setString(StorageKeys.locale, localeName);
  }

  void _persistDateType(String dateType) {
    state.sharedPreferences?.setString(StorageKeys.dateType, dateType);
  }

  void _persistSimNetwork(SimNetwork simNetwork) {
    state.sharedPreferences?.setString(StorageKeys.currentSimNetwork, simNetwork.name);
  }

  void _persistVatsimId(String vatsimId) {
    state.sharedPreferences?.setString(StorageKeys.vatsimId, vatsimId);
  }

  void _persistNavbarType(String navbarType) {
    state.sharedPreferences?.setString(StorageKeys.navbarType, navbarType);
  }

  void _persistMapProjection(String mapProjection) {
    state.sharedPreferences?.setString(StorageKeys.mapProjection, mapProjection);
  }

  void _persistAuthId(String authId) {
    state.sharedPreferences?.setString('authId', authId);
  }

  void _persistIsAuthenticated(String isAuthenticated) {
    state.sharedPreferences?.setString('isAuthenticated', isAuthenticated);
  }


  Future<Uri?> startAuthentication() async {
    state = state.copyWith(isAuthenticating: true);
    var redirectUri = dotenv.get('SFT_AUTH_RECIRECT_URL', fallback: 'https://dev.simflightstracker.com/oauth/callback');
    var vatsimAuthServer = dotenv.get('VATSIM_AUTH_SERVER_URL', fallback: 'https://auth-dev.vatsim.net');
    var vatsimClientId = dotenv.get('VATSIM_CLIENT_ID', fallback: '1117');

    var authId = await locator<GetStartAuthUseCase>().call('');

    if (authId == null || authId.isEmpty) {
      state = state.copyWith(isAuthenticating: false);
      showSnackBarNotification('Could not start authentication. Please try again later');
      return null;
    }

    final authUrl = Uri.parse(
      '$vatsimAuthServer/oauth/authorize'
      '?client_id=$vatsimClientId'
      '&redirect_uri=$redirectUri'
      '&response_type=code'
      '&scope=vatsim_details full_name country'
      '&prompt=consent'
      '&state=$authId',
    );

    return authUrl;
  }

  void logOutAuth() async {
    _persistAuthId('');
    _persistIsAuthenticated('false');
    _persistVatsimId('');

    await locator<VatsimLogoutUseCase>().call(state.vatsimAuthenticationId);

    state = state.copyWith(
        isAuthenticating: false,
        vatsimAuthenticationId: '',
        vatsimAuthenticated: false,
        authedUserDetails: null,
        vatsimId: ''
    );
  }

  void authFailed(String authId) async {

    if (authId.isNotEmpty) {
      await locator<VatsimLogoutUseCase>().call(authId);
    }

    state = state.copyWith(
      isAuthenticating: false,
      vatsimAuthenticationId: '',
      vatsimAuthenticated: false,
      authedUserDetails: null,
      vatsimId: ''
    );

    showSnackBarNotification('Authentication failed or cancelled. Please try again later');
  }

  void updateWebviewNavigating(bool isNavigating) {
    state = state.copyWith(isWebviewNavigating: isNavigating);
  }

  Future<void> completeAuthentication(String authId) async {
    state = state.copyWith(isAuthenticating: true);

    var authedUserDetails = await locator<GetAuthedUserDetailsUseCase>().call(authId);

    if (authedUserDetails == null) {
      state = state.copyWith(isAuthenticating: false);
      showSnackBarNotification('Could not retrieve user details. Please login.');
      return;
    }

    _persistAuthId(authId);
    _persistIsAuthenticated('true');
    _persistVatsimId(authedUserDetails.cid);

    ref.read(liveDataProvider.notifier).loadNetworkHistory(int.parse(authedUserDetails.cid), 0);

    state = state.copyWith(
      isAuthenticating: false,
      vatsimAuthenticationId: authId,
      vatsimAuthenticated: true,
      authedUserDetails: authedUserDetails,
      vatsimId: authedUserDetails.cid
    );
  }


  Future<void> _initInAppPurchases() async {
    InAppPurchase.instance.purchaseStream.listen(
      _listenToPurchaseUpdated,
      onError: (err) {
        log('Something went wrong subscribing to purchase stream');
      },
      onDone: () {
        log('Purchase stream subscription complete');
      },
    );
  }


  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) async {

    for (var product in purchaseDetailsList) {
      if (product.status == PurchaseStatus.pending) {
        state = state.copyWith(purchaseInProgress: true);
      } else {
        if (product.status == PurchaseStatus.purchased || product.status == PurchaseStatus.restored) {
          state = state.copyWith(purchaseInProgress: false);
          AppRouter.router.replaceNamed(AppRoutes.donationScreenSuccessNamed);
        } else {
          if (product.status == PurchaseStatus.error) {
            showSnackBarNotification('Could not complete payment. Please try again later');
          }
          state = state.copyWith(purchaseInProgress: false);
        }
      }

      if (product.pendingCompletePurchase) {
        await InAppPurchase.instance.completePurchase(product);
      }
    }
  }



  //  config bootstrap method. Bootstrap Bill Turner if you Will ... Turner
  Future<bool> boostrapAppConfiguration() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      SimNetwork simNetwork = SimNetwork.vatsim;

      String? savedSimNetwork = preferences.getString(StorageKeys.currentSimNetwork);
      String? savedVatsimId = preferences.getString(StorageKeys.vatsimId);
      String? savedLocale = preferences.getString(StorageKeys.locale);
      String? savedDateType = preferences.getString(StorageKeys.dateType);
      String? savedNavbarType = preferences.getString(StorageKeys.navbarType);
      String? savedMapProjection = preferences.getString(StorageKeys.mapProjection);
      String? savedAuthId = preferences.getString('authId');
      String savedIsAuthenticated = preferences.getString('isAuthenticated') ?? 'false';

      if (savedSimNetwork != null && savedSimNetwork.isNotEmpty) {
        simNetwork = SimNetwork.values.byNameOrDefault(savedSimNetwork, SimNetwork.vatsim);
      }

      var connectivityResult = await _fetchConnectivityResultAndMonitor();
      var atcSectors = await _fetchAirTrafficControlSectors();
      var airportData = await _fetchAirportData();
      var mapMarkerImages = await _fetchMapMarkerImages();

      await _initDioClient();
      // await _initFirebaseRemoteConfig();
      await _initInAppPurchases();


      var shortSide = PlatformDispatcher.instance.views.first.physicalSize.shortestSide /
          PlatformDispatcher.instance.views.first.devicePixelRatio;

      state = state.copyWith(
        vatsimId: savedVatsimId,
        currentLocale: savedLocale != null && savedLocale.isNotEmpty ? Locale(savedLocale) : Locale(SupportedLanguage.en.name),
        currentLanguage: SupportedLanguage.values.byNameOrDefault(savedLocale ?? '', SupportedLanguage.en),
        dateType: DateType.values.byNameOrDefault(savedDateType ?? '', DateType.zulu),
        navbarType: savedNavbarType,
        currentSimNetwork: simNetwork,
        appVersion: packageInfo.version,
        buildNumber: packageInfo.buildNumber,
        sharedPreferences: preferences,
        connectivityResult: connectivityResult,
        airports: airportData,
        airTrafficControlSectors: atcSectors,
        deliveryMarkerImage: mapMarkerImages.delivery,
        groundMarkerImage: mapMarkerImages.ground,
        towerMarkerImage: mapMarkerImages.tower,
        planeMarkerImage: mapMarkerImages.plane,
        configLoadedSuccessfully: true,
        mapProjection: savedMapProjection ?? 'mercator',
        isLargeScreenDevice: shortSide >= 600,
        vatsimAuthenticationId: savedAuthId ?? '',
        vatsimAuthenticated: savedIsAuthenticated.toLowerCase() == 'true',
      );

      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}