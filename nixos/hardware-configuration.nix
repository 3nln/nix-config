# Hardware configuration for NixOS
# This file should be generated with: nixos-generate-config --show-hardware-config > hardware-configuration.nix
{
  # Bootloader configuration
  boot.loader.systemd-boot.enable = true;

  # File systems
  fileSystems."/" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };

  # Set your system kind (needed for flakes)
  nixpkgs.hostPlatform = "x86_64-linux";
}
