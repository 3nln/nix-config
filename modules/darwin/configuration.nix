{
  pkgs,
  inputs,
  outputs,
  ...
}: {
  nixpkgs.overlays = [inputs.nix-vscode-extensions.overlays.default];

  imports = [
    ./flutter.nix
    ./homebrew.nix
  ];

  system.primaryUser = "nnolan";

  nixpkgs.hostPlatform = "aarch64-darwin";

  # Allow unfree + Android SDK licenses (required for Flutter)
  nixpkgs.config = {
    allowUnfree = true;
    android_sdk.accept_license = true;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  users.users.nnolan = {
    home = "/Users/nnolan";
  };

  system.stateVersion = 6;
}
