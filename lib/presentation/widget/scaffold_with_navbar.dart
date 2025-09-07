import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sim_flights_tracker/core/state/provider/providers.dart';

import '../../core/config/i10n/generated/app_localizations.dart';
import '../../core/theme/colors.dart';
import '../util/space_utils.dart';
import 'navigation/bottom_navbar.dart';
import 'no_connection_widget.dart';

class ScaffoldWithNavbar extends ConsumerWidget {
  final Widget child;

  const ScaffoldWithNavbar({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var connectivityResult = ref.watch(appConfigProvider.select((state) => state.connectivityResult));

    var theme = Theme.of(context);

    var hasNotice = false;
    var noticeMessage = '';

    return Container(
      color: SftColors.primaryDark,
      child: SafeArea(
        child: Scaffold(
          body: DoubleBackToCloseApp(
            snackBar: SnackBar(content: Text(AppLocalizations.of(context)!.tapToExit, style: const TextStyle(color: Colors.white),),
              backgroundColor: SftColors.lightOrange,
            ),
            child: switch (connectivityResult) {
              ConnectivityResult.none => const NoConnectionWidget(),
              _ => Column(
                children: [
                  if (hasNotice) Container(
                    color: Colors.red.shade800,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        const Icon(LineIcons.infoCircle, color: Colors.white,),
                        horizontalSpace(10),
                        Flexible(
                          child: Text(noticeMessage,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: child),
                ],
              )
            },
          ),
          bottomNavigationBar: (connectivityResult == ConnectivityResult.none)
            ? null
            : const BottomNavbar(),
        ),
      ),
    );
  }
}
