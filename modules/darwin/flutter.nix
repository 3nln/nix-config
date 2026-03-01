# Darwin: launchd env vars for Flutter
# Main Flutter setup — modules/home/flutter
{
  config,
  pkgs,
  ...
}: let
  home = config.users.users.${config.system.primaryUser}.home;
in {
  launchd.user.envVariables = {
    # Point to nix store path directly — GUI apps (Android Studio) don't
    # inherit the user PATH, so symlinks in /etc/profiles/per-user/… are invisible.
    FLUTTER_ROOT = "${pkgs.flutter}";

    # dart-sdk inside flutter is a symlink → resolve to pkgs.dart directly
    DART_SDK = "${pkgs.dart}";

    # Android SDK — managed by Android Studio's own SDK Manager
    ANDROID_HOME = "${home}/Library/Android/sdk";
    ANDROID_SDK_ROOT = "${home}/Library/Android/sdk";

    # Java — use Android Studio's bundled JDK
    JAVA_HOME = "/Applications/Android Studio.app/Contents/jbr/Contents/Home";
  };
}