import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

AdRequest request = const AdRequest(
  nonPersonalizedAds: true,
);
String interstitialAdId = "ca-app-pub-5941337395485186/1829382878";
//Demo
//String interstitialAdId = "ca-app-pub-3940256099942544/1033173712";
String getInterstitialAdUnitId() {
  if (Platform.isIOS) {
    return interstitialAdId;
  } else if (Platform.isAndroid) {
    return interstitialAdId;
  }
  return "";
}

String rewardAdId = "ca-app-pub-5941337395485186/2038649323";
//Demo
//String rewardAdId = "ca-app-pub-3940256099942544/5224354917";
String getRewardBasedVideoAdUnitId() {
  if (Platform.isIOS) {
    return rewardAdId;
  } else if (Platform.isAndroid) {
    return rewardAdId;
  }
  return "";
}

/*String bannerAdId = "ca-app-pub-5941337395485186/3960382886";
String getBannerAdUnitId() {
  if (Platform.isIOS) {
    return bannerAdId;
  } else if (Platform.isAndroid) {
    return bannerAdId;
  }
  return "";
}*/
