{ pkgs, inputs, outputs, ... }:

{
  nixpkgs.hostPlatform = "aarch64-darwin";
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Apply overlays from the overlays folder
  nixpkgs.overlays = [
    outputs.overlays.vscode-extensions
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = with pkgs; [
    kitty
    fastfetch
    firefox
    postman
    zed-editor
    vscode
  ];

  users.users.neo = {
    home = "/Users/neo";
  };

  system.stateVersion = 6;
}
