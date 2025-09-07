import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sim_flights_tracker/core/theme/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final Widget title;

  const CustomAppBar({super.key, required this.title, this.preferredSize = const Size.fromHeight(kToolbarHeight)});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: SftColors.primaryDark,
      title: title,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => context.pop(),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: SftColors.lightGreen.withValues(alpha: 0.5),),
      )
    );
  }
}
