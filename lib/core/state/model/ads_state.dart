import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

@immutable
class AdsState {
  final InterstitialAd? interstitialAd;

  const AdsState({
    this.interstitialAd,
  });

  AdsState copyWith(InterstitialAd? interstitialAd) {
    return AdsState(interstitialAd: interstitialAd);
  }
}