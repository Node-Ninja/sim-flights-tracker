import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sim_flights_tracker/core/constants/app_routes.dart';

import '../../core/theme/colors.dart';

class CommonSearchBar extends StatelessWidget {
  final Widget searchField;
  final bool shouldPop;
  final bool showBackButton;
  final Color background;
  const CommonSearchBar({super.key, required this.searchField, this.shouldPop = false, this.background = SftColors.primaryDark, this.showBackButton = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: background,
        border: const Border(
          bottom: BorderSide(color: SftColors.lightGreen)
        )
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          if (showBackButton) IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),
            onPressed: () {
              shouldPop ? context.pop() : context.go(AppRoutes.homeScreen);
            }
          ),
          Expanded(child: searchField)
        ],
      ),
    );
  }
}
