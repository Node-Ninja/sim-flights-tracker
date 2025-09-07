import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import '../../../core/config/i10n/generated/app_localizations.dart';
import 'package:sim_flights_tracker/core/theme/spacing.dart';

import '../../util/space_utils.dart';

class GenericErrorScreen extends StatelessWidget {
  final String message;
  const GenericErrorScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: Spacing.standardPaddingInset,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(LineIcons.exclamationCircle, size: 200,),
                Text(message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
                verticalSpace(10),
                TextButton(
                  onPressed: () => context.pop(),
                  child: Text(AppLocalizations.of(context)!.goBack),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
