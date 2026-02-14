{pkgs, inputs, outputs, lib, ... }:
let
  homeModules = import ./modules/home;
  inherit (pkgs) stdenv;
 home =
    if stdenv.hostPlatform.isDarwin
    then "Users"
    else "home";
in
{
  home.username = "nnolan";
  home.homeDirectory = "/${home}/nnolan";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  imports = [
    homeModules.fastfetch
    # homeModules.ghostty
    homeModules.git
    # homeModules.packages
    homeModules.ssh
    homeModules.zed-editor
  ];
}