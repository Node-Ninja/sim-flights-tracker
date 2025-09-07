import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sim_flights_tracker/core/constants/app_routes.dart';
import 'package:sim_flights_tracker/core/theme/spacing.dart';
import 'package:sim_flights_tracker/presentation/util/space_utils.dart';

class DonateSuccessScreen extends StatelessWidget {
  const DonateSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      body: Container(
        padding: Spacing.standardPaddingInset,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/sft_transparent.png', height: 200,),
              Text('Thank You, Captain', style: theme.textTheme.displaySmall,),
              verticalSpace(20),
              Text(
                'Thank you for your generous contribution! Your support helps keep the app running smoothly, enables regular updates, and ensures I can continue improving the experience for everyone. I truly appreciate your contribution!',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge!.copyWith(color: Colors.grey),
              ),
              verticalSpace(20),
              TextButton(
                onPressed: () => context.canPop() ? context.pop() : context.goNamed(AppRoutes.homeScreenNamed),
                child: Text('Done'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
