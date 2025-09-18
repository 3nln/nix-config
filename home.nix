{pkgs, ... }:
let
  homeModules = import ./modules/home;
in
{
  home.username = "neo";
  home.homeDirectory = "/Users/neo";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  # Install Node.js and related tools
  home.packages = with pkgs; [
    # Frontend
    nodejs
    nodePackages.npm
    nodePackages.pnpm
    nodePackages.yarn

    # Rust
    rustup
  ];

  imports = [
    homeModules.fastfetch
    homeModules.git
    homeModules.kitty
    homeModules.vscode
    homeModules.zed-editor
    homeModules.ssh
    homeModules.fish
  ];
}
