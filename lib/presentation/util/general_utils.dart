import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../core/globals/globals.dart';
import '../../core/theme/colors.dart';
import '../../core/utils.dart';



BannerAd createBannerAd() {
  return BannerAd(
    adUnitId: bannerAdUnitId(),
    request: const AdRequest(),
    size: AdSize.banner,
    listener: BannerAdListener(
      onAdFailedToLoad: (ad, err) => ad.dispose(),
    ),
  );
}

void showSnackBarNotification(String message, { bool isSticky = false }) {
  snackBarKey.currentState?.showSnackBar(SnackBar(
    content: Text(message, style: const TextStyle(
      color: SftColors.customGrey,
    ),),
    duration: isSticky ? Duration(days: 1) : Duration(seconds: 2),
    backgroundColor: SftColors.lightOrange,
    behavior: SnackBarBehavior.floating,
    showCloseIcon: !isSticky,

  ));
}