{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Hardware-specific kernel modules for Intel i7-11700K and AMD RX580
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usb_storage"
    "usbhid"
    "sd_mod"
    "amdgpu"
    "radeon"
    "i915"
    "kvm-intel"
  ];
  boot.initrd.kernelModules = ["amdgpu"];
  boot.kernelModules = ["kvm-intel" "amdgpu"];
  boot.extraModulePackages = [];

  # File systems (update these UUIDs based on your actual installation)
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/0ab6e8cb-bf62-4cc4-a362-e01c89078b98";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/3E1B-3CDA";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  # Swap configuration for 32GB RAM
  swapDevices = [];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # Intel CPU microcode updates
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Enable redistributable firmware for AMD GPU
  hardware.enableRedistributableFirmware = true;

  hardware.bluetooth.enable = true;
}
