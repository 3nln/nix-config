{ ... }:
let
  homeModules = ./modules/home;
in
{
  home.username = "neo";
  home.homeDirectory = "/Users/neo";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  imports = [
    homeModules.fastfetch
    homeModules.git
    homeModules.kitty
    homeModules.vscode
    homeModules.zed-editor
    homeModules.ssh
  ];
}
