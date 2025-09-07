import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:sim_flights_tracker/core/extensions/string_extensions.dart';
import 'package:sim_flights_tracker/core/state/provider/providers.dart';
import 'package:sim_flights_tracker/presentation/util/space_utils.dart';

import '../../../core/config/i10n/generated/app_localizations.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/theme/colors.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key,});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    var navigationItemColor = SftColors.customGrey;
    var navigationWidgetWidth = screenWidth / 5;
    const double indicatorSeparation = 12;

    return Container(
        decoration: BoxDecoration(
          color: SftColors.primaryDark,
          border: Border(
            top: BorderSide(
              color: SftColors.lightGreen.withValues(alpha: 0.2),
            ),
          ),
        ),
        child: Consumer(
          builder: (context, ref, _) => (ref.read(appConfigProvider).navbarType == 'reveal')
              ? _googleNavbar(context)
              : _modernNavbar(context, navigationWidgetWidth, navigationItemColor, indicatorSeparation),
        )
    );
  }

  Widget _modernNavbar(context, navigationWidgetWidth, navigationItemColor, indicatorSeparation) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Stack(
        children: [
          AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              width: navigationWidgetWidth,
              height: 4,
              bottom: 0,
              left: _calculateIndicatorLocation(context, navigationWidgetWidth),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    decoration: BoxDecoration(
                        color: SftColors.lightOrange.withValues(alpha: 0.8),
                        borderRadius: const BorderRadius.all(Radius.circular(17))
                    ),
                  ),
                ],
              )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _navigate(context, 0),
                  behavior: HitTestBehavior.opaque,
                  child:
                  _modernNavbarItem(
                      context,
                      Symbols.home,
                      AppLocalizations.of(context)!.home,
                      indicatorSeparation,
                      navigationItemColor
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => _navigate(context, 1),
                  behavior: HitTestBehavior.opaque,
                  child: _modernNavbarItem(
                      context,
                      Symbols.radar,
                      AppLocalizations.of(context)!.controllers,
                      indicatorSeparation,
                      navigationItemColor
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => _navigate(context, 2),
                  behavior: HitTestBehavior.opaque,
                  child: _modernNavbarItem(
                      context,
                      Symbols.flight,
                      AppLocalizations.of(context)!.flights,
                      indicatorSeparation,
                      navigationItemColor
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => _navigate(context, 3),
                  behavior: HitTestBehavior.opaque,
                  child: _modernNavbarItem(
                      context,
                      Symbols.map,
                      AppLocalizations.of(context)!.map,
                      indicatorSeparation,
                      navigationItemColor
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => _navigate(context, 4),
                  behavior: HitTestBehavior.opaque,
                  child: _modernNavbarItem(
                      context,
                      Symbols.menu,
                      AppLocalizations.of(context)!.menu,
                      indicatorSeparation,
                      navigationItemColor
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _googleNavbar(context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GNav(
        gap: 10,
        tabActiveBorder: Border.all(color: SftColors.lightGreen),
        activeColor: Colors.white,
        padding: const EdgeInsets.all(10),
        color: SftColors.customGrey,
        tabBackgroundColor: SftColors.primary,
        iconSize: 25,
        tabs: [
          GButton(
            icon: Symbols.home,
            text: AppLocalizations.of(context)!.home,
          ),
          GButton(
            icon: Symbols.radar,
            text: AppLocalizations.of(context)!.controllers,
          ),
          GButton(
            icon: Symbols.flight,
            text: AppLocalizations.of(context)!.flights,
          ),
          GButton(
            icon: Symbols.map,
            text: AppLocalizations.of(context)!.map,
          ),
          GButton(
            icon: Symbols.menu,
            text: AppLocalizations.of(context)!.menu,
          ),
        ],
        selectedIndex: _calculateSelectedIndex(context),
        onTabChange: (index) => _navigate(context, index),
      ),
    );
  }

  Widget _modernNavbarItem(context, IconData icon, String label, double indicatorSeparation, Color navigationItemColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: navigationItemColor,),
        Text((label.length <= 8) ? label : '${label.takeFirst(7)}...', overflow: TextOverflow.ellipsis,),
        verticalSpace(indicatorSeparation),
      ],
    );
  }

  void _navigate(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(AppRoutes.homeScreen);
        break;
      case 1:
        context.go(AppRoutes.controllersScreen);
        break;
      case 2:
        context.go(AppRoutes.flightsScreen);
        break;
      case 4:
        context.go(AppRoutes.menuScreen);
        break;
      case 3:
        context.go(AppRoutes.mapScreen);
        break;
      default:
        context.go(AppRoutes.homeScreen);
    }
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String currentLocation = GoRouterState.of(context).uri.toString();

    if (currentLocation.contains(AppRoutes.homeScreen)) return 0;
    if (currentLocation.contains(AppRoutes.controllersScreen)) return 1;
    if (currentLocation.contains(AppRoutes.flightsScreen)) return 2;
    if (currentLocation.contains(AppRoutes.menuScreen)) return 4;
    if (currentLocation.contains(AppRoutes.mapScreen)) return 3;

    return 0;
  }

  static double _calculateIndicatorLocation(context, navigationWidgetWidth) {
    return _calculateSelectedIndex(context) == 1
        ? navigationWidgetWidth
        : _calculateSelectedIndex(context) == 2
        ? navigationWidgetWidth * 2
        : _calculateSelectedIndex(context) == 3
        ? navigationWidgetWidth * 3
        : _calculateSelectedIndex(context) == 4
        ? navigationWidgetWidth * 4 : 0;
  }
}
