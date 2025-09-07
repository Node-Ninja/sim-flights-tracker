import 'package:flutter/material.dart';
import '../../../core/config/i10n/generated/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../core/theme/colors.dart';
import '../../util/space_utils.dart';

class NotFoundScreen extends StatelessWidget {
  final String message;
  final bool showBackAction;
  const NotFoundScreen({super.key, required this.message, this.showBackAction = true});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Symbols.error_circle_rounded,
                  size: 200,
                  color: SftColors.lightGreen,
                ),
                Text(message.isNotEmpty ? message : AppLocalizations.of(context)!.screenNotFound,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white,),
                ),
                verticalSpace(20),
                if (showBackAction) TextButton(
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
