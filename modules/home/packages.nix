{ pkgs, ... }:

{
  # Aggregated list of simple, non-configurable desktop apps
  home.packages = with pkgs; [
    telegram-desktop
    flameshot

    # dev tools
    jetbrains.webstorm
    # kitty
    # kitty-themes

    # Media
    vlc

    # tools
    btop

    # Frontend
    nodejs
    nodePackages.npm
    nodePackages.pnpm
    nodePackages.yarn

    # Rust
    rustup

    # Golang
    go
  ];
}
