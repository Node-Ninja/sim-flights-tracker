import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../utils.dart';
import '../model/ads_state.dart';

class AdsStateNotifier extends AsyncNotifier<AdsState> {

  @override
  AdsState build() => const AdsState();

  void refreshInterstitialAdvert() {
    state = const AsyncValue.loading();

    InterstitialAd.load(
      adUnitId: interstitialAdUnitId(),
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
                onAdDismissedFullScreenContent: (ad) {
                  ad.dispose();
                },
                onAdFailedToShowFullScreenContent: (ad, err) {
                  ad.dispose();
                }
            );

            state = AsyncValue.data(AdsState(interstitialAd: ad));
          },
          onAdFailedToLoad: (LoadAdError error) {
            state = AsyncValue.error(error, StackTrace.current);
          }
      ),
    );
  }
}