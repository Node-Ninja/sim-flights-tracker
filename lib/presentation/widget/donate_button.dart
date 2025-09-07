import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';

import '../../core/config/i10n/generated/app_localizations.dart';
import '../../core/constants/app_routes.dart';
import '../util/space_utils.dart';

class  DonateButton extends StatelessWidget {
  const DonateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // https://www.paypal.com/donate/?hosted_button_id=V765SEEGBJQRA
        // openBrowser('https://www.paypal.com/donate/?hosted_button_id=V765SEEGBJQRA');
        context.pushNamed(AppRoutes.donationScreenNamed);
      },
      child: Row(
        children: [
          Icon(LineIcons.coffee),
          horizontalSpace(5),
          Text(AppLocalizations.of(context)!.donatePaypal),
        ],
      ),
    );
  }
}
