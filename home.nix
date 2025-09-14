{ pkgs, ... }:

{
  home.username = "neo";
  home.homeDirectory = "/Users/neo";
  home.stateVersion = "25.05";

  programs.fish.enable = true;

  imports = [
    ../modules/programs/kitty.nix
    ../modules/programs/vscode.nix
    ../modules/programs/zed-editor.nix
  ];
}
