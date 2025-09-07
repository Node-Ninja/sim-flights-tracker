import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../core/config/i10n/generated/app_localizations.dart';

class SftLoader extends StatelessWidget {
  final String message;

  const SftLoader({super.key, this.message = ''});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottie/flight_cloud.json',
                width: 200,
                frameRate: FrameRate.max
            ),
            Text(message == '' ? AppLocalizations.of(context)!.loaderText : message, style: theme.textTheme.bodySmall,)
          ],
        )
    );
  }
}
