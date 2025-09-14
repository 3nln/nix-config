{ pkgs, ... }:

{
  nixpkgs.hostPlatform = "aarch64-darwin";
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = with pkgs; [
    kitty
    fastfetch
    firefox
    vlc
    postman
    zed-editor
    vscode
  ];

  users.users.neo = {
    home = "/Users/neo";
  };

  system.stateVersion = 6;
}
