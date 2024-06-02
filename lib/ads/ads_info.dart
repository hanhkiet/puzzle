import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

AdRequest request = const AdRequest(
  nonPersonalizedAds: true,
);
String interstitialAdId = "ca-app-pub-8948935600533196/5722260964";
String getInterstitialAdUnitId() {
  if (Platform.isIOS) {
    return interstitialAdId;
  } else if (Platform.isAndroid) {
    return interstitialAdId;
  }
  return "";
}

String rewardAdId = "ca-app-pub-8948935600533196/2205687788";
String getRewardBasedVideoAdUnitId() {
  if (Platform.isIOS) {
    return rewardAdId;
  } else if (Platform.isAndroid) {
    return rewardAdId;
  }
  return "";
}

String bannerAdId = "ca-app-pub-8948935600533196/5530689278";
String getBannerAdUnitId() {
  if (Platform.isIOS) {
    return bannerAdId;
  } else if (Platform.isAndroid) {
    return bannerAdId;
  }
  return "";
}
