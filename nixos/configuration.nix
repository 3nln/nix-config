{ config, pkgs, inputs, outputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  # Apply overlays from the overlays folder
  nixpkgs.overlays = [
    outputs.overlays.vscode-extensions
  ];

  # Bootloader configuration for Gigabyte Z590
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Boot configuration optimizations
  boot.kernelParams = [
    "amd_iommu=on"
    "iommu=pt"
    "pci=realloc"
    "video=DP-1:2560x1080@75"  # For LG 29" ultrawide
  ];

  # Enable kernel hardening and memory optimizations
  boot.kernel.sysctl = {
    "kernel.unprivileged_bpf_disabled" = 1;
    "net.core.bpf_jit_harden" = 2;
    "vm.swappiness" = 10;
    "vm.vfs_cache_pressure" = 50;
    "vm.dirty_ratio" = 15;
    "vm.dirty_background_ratio" = 5;
  };

    nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    gc = {
      automatic = true;
      options = "--delete-older-than 10d";
    };
    };

  networking.hostName = "nixos";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Tashkent";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system with AMD GPU support
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  # AMD GPU configuration
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      amdvlk
    ];
    extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
    ];
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11 for 2E Gaming KG380WL
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "compose:rctrl";
  };

  # Enable automatic login for better gaming experience
  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = "neo";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account with gaming groups
  users.users.neo = {
    isNormalUser = true;
    description = "neo";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "audio"
      "games"
      "input"
      "render"
    ];
    packages = with pkgs; [];
  };

  # Home Manager configuration
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.neo = import ../home.nix;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages optimized for gaming and development
  environment.systemPackages = with pkgs; [
    home-manager

    # Gaming essentials
    steam
    lutris
    wine
    winetricks
    vulkan-tools
    vulkan-loader
    vulkan-validation-layers

    # AMD GPU tools
    radeontop
    mesa-demos

    # Performance monitoring
    cpupower-gui

    vim
    nano
    curl
    wget

    # Media and codecs
    ffmpeg
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
  ];

  # Performance optimizations for i7-11700K
  powerManagement.cpuFreqGovernor = "performance";

  # Enable CPU frequency scaling
  services.thermald.enable = true;


  # Enable real-time scheduling for audio
  security.rtkit.enable = true;

  # Gaming optimizations
  programs.gamemode.enable = true;

  # Enable udev rules for gaming peripherals
  services.udev.extraRules = ''
    # 2E Gaming KG380WL keyboard
    SUBSYSTEM=="usb", ATTRS{idVendor}=="258a", ATTRS{idProduct}=="1007", MODE="0666", GROUP="games"

    # AMD GPU
    KERNEL=="kfd", GROUP="render", MODE="0664"
    KERNEL=="dri/*", GROUP="video", MODE="0664"
  '';

  system.stateVersion = "25.05";
}
