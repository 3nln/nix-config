{
  lib,
  pkgs,
  config,
  ...
}:

let

  buildToolsVersion = "35.0.0";
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    cmdLineToolsVersion = "13.0";
    platformToolsVersion = "35.0.2";
    buildToolsVersions = [ buildToolsVersion ];
    platformVersions = [ "35" ];
    includeEmulator = false;
    includeSystemImages = false;
    includeSources = false;
    includeNDK = false;
    useGoogleAPIs = false;
    useGoogleTVAddOns = false;
    extraLicenses = [
      "android-sdk-arm-dbt-license"
      "android-sdk-license"
      "android-sdk-preview-license"
      "google-gdk-license"
    ];
  };
  androidSdk = androidComposition.androidsdk;
in
{
  home.packages = with pkgs; [
    jdk17
    androidSdk
    android-tools
    flutter
  ];

  home.sessionVariables = {
    ANDROID_HOME = "${androidSdk}/libexec/android-sdk";
    ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
    JAVA_HOME = "${pkgs.jdk17.home}";
    GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${androidSdk}/libexec/android-sdk/build-tools/${buildToolsVersion}/aapt2";
    DART_SDK = "${pkgs.flutter}/bin/cache/dart-sdk";
    FLUTTER_ROOT = "${pkgs.flutter}";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.pub-cache/bin"
  ];

  # Symlinks for Android Studio — created in user context
  home.activation.setupFlutterSdks = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p $HOME/sdks
    ln -sfn ${pkgs.flutter}/bin/cache/dart-sdk $HOME/sdks/dart-sdk
    ln -sfn ${pkgs.flutter} $HOME/sdks/flutter
  '';
}
