{
  pkgs,
  lib,
  ...
}: let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
in {
  # Aggregated list of simple, non-configurable desktop apps
  home.packages = with pkgs;
    [
      # Common CLI/dev tools
      btop
      nixfmt
      rustup
      go
      bun
      # JetBrains
      jetbrains-toolbox
      jetbrains.webstorm
      jetbrains.rust-rover
    ]
    ++ lib.optionals isLinux [
      telegram-desktop
      flameshot
      # Font: macOS gets this via Homebrew cask font-jetbrains-mono
      jetbrains-mono
    ];
}
