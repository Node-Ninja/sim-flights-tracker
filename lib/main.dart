import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sim_flights_tracker/core/dependency_injection/injection_container.dart';
import 'package:sim_flights_tracker/sim_flights_tracker.dart';

import 'core/theme/colors.dart';


bool isLargeScreenDevice = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // await FirebaseAppCheck.instance.activate(
  //   androidProvider: (kDebugMode) ? AndroidProvider.debug : AndroidProvider.playIntegrity,
  //   appleProvider: (kDebugMode) ? AppleProvider.debug : AppleProvider.appAttest
  // );

  // await MobileAds.instance.initialize();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: SftColors.primaryDark,
      systemNavigationBarColor: SftColors.primaryDark,
    )
  );

  await initLocator();

  await dotenv.load(fileName: '.env');

  runApp(
    ProviderScope(child: const SimFlightsTracker())
  );
}