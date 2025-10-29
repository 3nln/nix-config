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

    # Gaming
    steam

    # tools
    btop

    # Frontend
    nodejs
    nodePackages.npm
    nodePackages.pnpm
    nodePackages.yarn
    typescript

    # Backend
    nest-cli
    prisma
    pgadmin4
    postgresql_16
    redis
    mongodb
    mongodb-cli

    git

    # Rust
    rustup

    # Golang
    go
  ];
}
