import 'dart:io';

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:sim_flights_tracker/core/theme/spacing.dart';

import '../../core/config/i10n/generated/app_localizations.dart';

class NoConnectionWidget extends StatelessWidget {
  const NoConnectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Symbols.wifi_off_rounded, size: 200,),
          Padding(
            padding: Spacing.standardPaddingInset,
            child: Text(AppLocalizations.of(context)!.lostInternetConnection,
              textAlign: TextAlign.center,
            ),
          ),
          if (Platform.isAndroid) TextButton(onPressed: () => exit(0), child: const Text('Exit'))
        ],
      ),
    );
  }
}
