import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ads_info.dart';

class AdsFile {
  BuildContext? context;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;

  AdsFile(BuildContext c) {
    context = c;
    setDefaultData();
  }

  setDefaultData() async {
    // isAppPurchased = await PrefData.getIsAppPurchased();
    // isAdsPermission = await PrefData.getIsAppAdsPermission();
  }

  BannerAd? _anchoredBanner;

  Future<void> createAnchoredBanner(BuildContext context, var setState,
      {Function? function}) async {
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getAnchoredAdaptiveBannerAdSize(
      Orientation.portrait,
      MediaQuery.of(context).size.width.truncate(),
    );

    if (size == null) {
      if (kDebugMode) {
        print('Unable to get height of anchored banner.');
      }
      return;
    }

    final BannerAd banner = BannerAd(
      size: size,
      request: request,
      adUnitId: getBannerAdUnitId(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          if (kDebugMode) {
            print('$BannerAd loaded.');
          }
          setState(() {
            _anchoredBanner = ad as BannerAd?;
          });
          if (function != null) {
            function();
          }
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          if (kDebugMode) {
            print('$BannerAd failedToLoad: $error');
          }
          ad.dispose();
        },
        onAdOpened: (ad) {
          if (kDebugMode) {
            print('$BannerAd onAdOpened.');
          }
        },
        onAdClosed: (ad) {
          if (kDebugMode) {
            print('$BannerAd onAdClosed.');
          }
        },
      ),
    );
    return banner.load();
    // }
  }

  void disposeInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.dispose();
    }
  }

  void disposeRewardedAd() {
    if (_rewardedAd != null) {
      _rewardedAd!.dispose();
    }
  }

  void disposeBannerAd() {
    if (_anchoredBanner != null) {
      _anchoredBanner!.dispose();
    }
  }

  void showInterstitialAd(Function function) {
    if (_interstitialAd == null) {
      if (kDebugMode) {
        print('Warning: attempt to show interstitial before loaded.');
      }

      function();

      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) {
        if (kDebugMode) {
          print('ad onAdShowedFullScreenContent.');
        }
      },
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        if (kDebugMode) {
          print('$ad onAdDismissedFullScreenContent.');
        }
        ad.dispose();
        function();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        if (kDebugMode) {
          print('$ad onAdFailedToShowFullScreenContent: $error');
        }
        ad.dispose();
        createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  void showRewardedAd(Function function, Function function1) async {
    bool isRewarded = false;
    if (_rewardedAd == null) {
      function1();
      // showToast(S.of(context!).videoError);
      if (kDebugMode) {
        print('Warning: attempt to show rewarded before loaded.');
      }
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) {
        if (kDebugMode) {
          print('ad onAdShowedFullScreenContent.');
        }
      },
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        if (kDebugMode) {
          print('$ad onAdDismissedFullScreenContent.');
        }
        ad.dispose();

        if (isRewarded) {
          function();
        } else {
          function1();
        }
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        if (kDebugMode) {
          print('$ad onAdFailedToShowFullScreenContent: $error');
        }
        ad.dispose();
      },
    );

    // _rewardedAd!.show(onUserEarnedReward: (RewardedAd ad, RewardItem reward) {
    //   _isRewarded = true;
    //   print('$ad with reward $RewardItem(${reward.amount}, ${reward.type}');
    // });

    _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      isRewarded = true;
      _rewardedAd = null;
      // print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
  }

  void createRewardedAd() {
    // if(!isAppPurchased ) {
    RewardedAd.load(
        adUnitId: getRewardBasedVideoAdUnitId(),
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            if (kDebugMode) {
              print('reward====$ad loaded.');
            }
            _rewardedAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            if (kDebugMode) {
              print('RewardedAd failed to load: $error');
            }
            _rewardedAd = null;
            createRewardedAd();
          },
        ));
  }

  void createInterstitialAd() {
    // if(!isAppPurchased  ) {
    // if(!isAppPurchased  && isAdsPermission) {
    InterstitialAd.load(
        adUnitId: getInterstitialAdUnitId(),
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            if (kDebugMode) {
              print('$ad loaded');
            }
            if (kDebugMode) {
              print('failed==== true');
            }

            _interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            if (kDebugMode) {
              print('InterstitialAd failed to load: $error.');
            }
            // _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (kDebugMode) {
              print('failed==== loaded');
            }

            // if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
            createInterstitialAd();
            // }
          },
        ));
  }
// }
}

getBanner(BuildContext context, AdsFile? adsFile) {
  if (adsFile == null) {
    return Container();
  } else {
    return showBanner(context, adsFile);
  }
}

showRewardedAd(AdsFile? adsFile, Function function, {Function? function1}) {
  if (adsFile != null) {
    adsFile.showRewardedAd(() {
      function();
    }, () {
      if (function1 != null) {
        function1();
      }
    });
  }
}

showInterstitialAd(AdsFile? adsFile, Function function) {
  if (adsFile != null) {
    adsFile.showInterstitialAd(() {
      function();
    });
  } else {
    function();
  }
}

disposeRewardedAd(AdsFile? adsFile) {
  if (adsFile != null) {
    adsFile.disposeRewardedAd();
  }
}

disposeInterstitialAd(AdsFile? adsFile) {
  if (adsFile != null) {
    adsFile.disposeInterstitialAd();
  }
}

disposeBannerAd(AdsFile? adsFile) {
  if (adsFile != null) {
    adsFile.disposeBannerAd();
  }
}

showBanner(BuildContext context, AdsFile adsFile) {
  return Container(
    height: (getBannerAd(adsFile) != null)
        ? getBannerAd(adsFile)!.size.height.toDouble()
        : 0,
    // color: Colors.black,
    color: Theme.of(context).scaffoldBackgroundColor,
    child: (getBannerAd(adsFile) != null)
        ? AdWidget(ad: getBannerAd(adsFile)!)
        : Container(),
  );
}

BannerAd? getBannerAd(AdsFile? adsFile) {
  BannerAd? anchoredBanner;
  if (adsFile != null) {
    return (adsFile._anchoredBanner == null)
        ? anchoredBanner
        : adsFile._anchoredBanner!;
  } else {
    return anchoredBanner!;
  }
}
