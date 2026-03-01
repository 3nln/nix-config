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
      just
      nixfmt
      rustup
      go
      bun
      # Node.js
      nodejs
      nodePackages.npm
      # Messaging
      telegram-desktop
      # JetBrains
      jetbrains-toolbox
      jetbrains.webstorm
      jetbrains.rust-rover
      flameshot
    ]
    ++ lib.optionals isLinux [
      # Font: macOS gets this via Homebrew cask font-jetbrains-mono
      jetbrains-mono
    ];
}
