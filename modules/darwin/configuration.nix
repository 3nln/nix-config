{ pkgs, inputs, outputs, ... }:

{
  nixpkgs.hostPlatform = "aarch64-darwin";
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  users.users.neo = {
    home = "/Users/neo";
  };

  system.stateVersion = 6;
}