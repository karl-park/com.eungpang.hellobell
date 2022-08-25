class AppConstant {
  static const String appName = "HelloBell";
  static const String androidAppId = "com.eungpang.hellobell";
  static const String googlePlayStoreUrl =
      "https://play.google.com/store/apps/details?id=${AppConstant.androidAppId}";

  // FIXME: after uploading, change it
  static const String iOSAppId = "1641663835";
  static const String appStoreUrl =
      "https://apps.apple.com/<country>/app/hellobell/id${AppConstant.iOSAppId}";
}
