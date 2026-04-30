{pkgs, ...}: {
  homebrew = {
    enable = true;

    # taps = [ "mongodb/brew" ];

    # macOS-native desktop apps not available (or not suitable) via nixpkgs.
    # Prerequisite: install Homebrew manually once:
    #   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    casks = [
      "ghostty" # nixpkgs ghostty is Linux-only; macOS via Homebrew
      "font-jetbrains-mono" # nixpkgs build broken on aarch64-darwin (ttfautohint segfault)
      "google-chrome"
      # "android-studio"
      "raycast"
      "github"
      "macs-fan-control"
      "zed" # nixpkgs zed-editor rebuilds from source on aarch64-darwin (cache miss)

      # "vlc"
      # "mongodb-compass"
    ];

    # brews = [
    #   "mongodb-community"
    #   "mongosh"
    # ];

    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "none";
    };
  };
}
