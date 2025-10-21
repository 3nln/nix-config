{ pkgs, ... }:

{
  # Aggregated list of simple, non-configurable desktop apps
  home.packages = with pkgs; [
    telegram-desktop
    jetbrains.webstorm
  ];
}


