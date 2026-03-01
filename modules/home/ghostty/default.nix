{
  pkgs,
  lib,
  ...
}: let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  isLinux = pkgs.stdenv.hostPlatform.isLinux;

  # Shared settings for both platforms
  commonSettings = {
    theme = "light:Horizon Bright,dark:Broadcast";
    font-family = "JetBrains Mono";
    font-size = 16;
    window-padding-x = 10;
    window-padding-y = 10;
    window-decoration = true;
    cursor-style = "block";
    adjust-cell-height = "35%";
    mouse-scroll-multiplier = 2;
    copy-on-select = "clipboard";
    window-padding-balance = true;
    window-save-state = "always";
    background-opacity = 0.7;
    background-blur = 80;
  };

  darwinSettings = {
    macos-titlebar-style = "transparent";
    window-colorspace = "display-p3";
  };

  # Ghostty config format: one "key = value" per line
  toGhosttyConfig = settings:
    lib.concatStringsSep "\n" (
      lib.mapAttrsToList (k: v: "${k} = ${builtins.toString v}") settings
    )
    + "\n";
in {
  # Linux: home-manager module installs ghostty + writes config
  programs.ghostty = lib.mkIf isLinux {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.ghostty;
    settings = commonSettings;
  };

  # macOS: nixpkgs ghostty is Linux-only; write config directly so that
  # Homebrew-installed (or manually installed) Ghostty.app picks it up.
  xdg.configFile."ghostty/config" = lib.mkIf isDarwin {
    text = toGhosttyConfig (commonSettings // darwinSettings);
  };
}
