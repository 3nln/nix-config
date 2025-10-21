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
  home.username = "neo";
  home.homeDirectory = "/${home}/neo";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  # Install tools and packages
  home.packages = with pkgs; [
    # tools
    btop

    # Media
    vlc

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

  imports = [
    homeModules.fastfetch
    homeModules.git
    homeModules.kitty
    homeModules.vscode
    homeModules.zed-editor
    homeModules.ssh
    homeModules.fish
    homeModules.helix
    homeModules.telegram
    homeModules.jetbrains
  ];
}
