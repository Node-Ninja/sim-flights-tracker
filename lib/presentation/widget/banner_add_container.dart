import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Widget bannerAdContainer(BannerAd? bannerAd) {
  if (bannerAd != null) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      height: 60,
      child: AdWidget(ad: bannerAd,),
    );
  } else {
    return Container(height: 60,);
  }
}