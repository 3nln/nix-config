{
  pkgs,
  inputs,
  outputs,
  lib,
  username ? "nnolan",
  ...
}: let
  homeModules = import ./modules/home;
  inherit (pkgs) stdenv;
  home =
    if stdenv.hostPlatform.isDarwin
    then "Users"
    else "home";
in {
  home.username = username;
  home.homeDirectory = "/${home}/${username}";
  home.stateVersion = "25.11";

  # Silence HM 25.11 vs nixpkgs-unstable (26.05) version mismatch warning
  home.enableNixpkgsReleaseCheck = false;

  # NOTE: nixpkgs.config is NOT set here.
  # Darwin: allowUnfree + android_sdk.accept_license are set in modules/darwin/configuration.nix
  #         and propagated to home-manager via home-manager.useGlobalPkgs = true.
  # Linux:  set inline in flake.nix homeManagerConfiguration modules list.

  programs.home-manager.enable = true;

  imports = [
    homeModules.fastfetch
    homeModules.flutter
    homeModules.ghostty
    homeModules.git
    homeModules.commands
    homeModules.packages
    homeModules.ssh
    homeModules.vscode
    # homeModules.zed-editor
    homeModules.zsh
  ];
}
