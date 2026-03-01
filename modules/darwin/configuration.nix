{
  pkgs,
  inputs,
  outputs,
  ...
}: {
  nixpkgs.overlays = [
    inputs.nix-vscode-extensions.overlays.default
    inputs.nur.overlays.default
  ];

  imports = [
    ./flutter.nix
    ./homebrew.nix
    ./wallpaper.nix
  ];

  system.primaryUser = "nnolan";

  nixpkgs.hostPlatform = "aarch64-darwin";

  # Allow unfree + Android SDK licenses (required for Flutter)
  nixpkgs.config = {
    allowUnfree = true;
    android_sdk.accept_license = true;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  users.users.nnolan = {
    home = "/Users/nnolan";
  };

  launchd.user.agents = {
    jetbrains-toolbox = {
      serviceConfig = {
        ProgramArguments = ["/usr/local/bin/jetbrains-toolbox" "--minimize"];
        RunAtLoad = true;
        KeepAlive = false;
      };
    };

    flameshot = {
      serviceConfig = {
        ProgramArguments = ["${pkgs.flameshot}/bin/flameshot"];
        RunAtLoad = true;
        KeepAlive = false;
      };
    };

    macfancontrol = {
      serviceConfig = {
        ProgramArguments = ["/Applications/Macs Fan Control.app/Contents/MacOS/Macs Fan Control"];
        RunAtLoad = true;
        KeepAlive = false;
      };
    };

    raycast = {
      serviceConfig = {
        ProgramArguments = ["/Applications/Raycast.app/Contents/MacOS/Raycast"];
        RunAtLoad = true;
        KeepAlive = false;
      };
    };
  };

  system.stateVersion = 6;
}
