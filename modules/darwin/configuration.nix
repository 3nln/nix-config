{ pkgs, inputs, outputs, ... }:

{
  nixpkgs.hostPlatform = "aarch64-darwin";
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  users.users.nnolan = {
    home = "/Users/nnolan";
  };

  system.stateVersion = 6;
}