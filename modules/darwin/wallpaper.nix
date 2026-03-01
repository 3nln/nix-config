{pkgs, ...}: let
  wallpaper = ../../wallpaper/blue-abstract-5120x2880-25119.jpg;

  setWallpaperAll = pkgs.writeShellScript "set-wallpaper-all" ''
    /usr/bin/osascript <<'APPLESCRIPT'
    tell application "System Events"
      repeat with d in desktops
        set picture of d to POSIX file "${wallpaper}"
      end repeat
    end tell
    APPLESCRIPT
  '';
in {
  launchd.user.agents.set-wallpaper-all = {
    serviceConfig = {
      ProgramArguments = ["${pkgs.bash}/bin/bash" "${setWallpaperAll}"];
      RunAtLoad = true;
      StartInterval = 60;
      KeepAlive = false;
      StandardOutPath = "/tmp/set-wallpaper-all.out";
      StandardErrorPath = "/tmp/set-wallpaper-all.err";
    };
  };
}
