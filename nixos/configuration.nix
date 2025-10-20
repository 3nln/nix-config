# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };
    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  # Essential system packages
  environment.systemPackages = with pkgs; [
    # Basic utilities
    vim
    nano
    wget
    curl
    git
    htop
    tree
    unzip
    zip
    
    # Development tools
    gcc
    gdb
    make
    cmake
    pkg-config
    
    # Network tools
    networkmanager
    nmap
    tcpdump
    
    # System utilities
    lshw
    pciutils
    usbutils
    dmidecode
    
    # Archive tools
    p7zip
    unrar
    
    # Terminal emulator
    alacritty
    
    # File manager
    ranger
    nnn
  ];

  # Set hostname
  networking.hostName = "neo-nixos";

  # Configure system-wide user settings
  users.users = {
    neo = {
      isNormalUser = true;
      description = "Neo";
      extraGroups = [
        "wheel"           # For sudo access
        "networkmanager"  # For network management
        "audio"          # For audio access
        "video"          # For video access
        "docker"         # For Docker access
        "libvirtd"       # For virtualization
        "plugdev"        # For USB devices
        "input"          # For input devices
      ];
      openssh.authorizedKeys.keys = [
        # Add your SSH public keys here
        # "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI..."
      ];
    };
  };

  # Network configuration
  networking.networkmanager.enable = true;
  
  # Enable wireless support
  hardware.wirelessRegulatoryDatabase = true;
  
  # Enable sound
  sound.enable = true;
  
  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    settings = {
      # Opinionated: forbid root login through SSH.
      PermitRootLogin = "no";
      # Opinionated: use keys only.
      # Remove if you want to SSH using passwords
      PasswordAuthentication = false;
    };
  };
  
  # Enable timesyncd for time synchronization
  services.timesyncd.enable = true;
  
  # Enable automatic system upgrades
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
  };
  
  # Bootloader configuration
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 5;
  };
  
  # Enable GRUB (alternative to systemd-boot)
  # boot.loader = {
  #   grub = {
  #     enable = true;
  #     device = "nodev";
  #     efiSupport = true;
  #     useOSProber = true;
  #   };
  #   efi.canTouchEfiVariables = true;
  # };
  
  # Desktop Environment - GNOME
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    
    # Configure keyboard layout
    layout = "us";
    xkbVariant = "";
  };
  
  # Alternative: KDE Plasma
  # services.xserver = {
  #   enable = true;
  #   desktopManager.plasma5.enable = true;
  #   displayManager.sddm.enable = true;
  # };
  
  # Alternative: XFCE
  # services.xserver = {
  #   enable = true;
  #   desktopManager.xfce.enable = true;
  #   displayManager.lightdm.enable = true;
  # };
  
  # Enable hardware acceleration
  hardware.opengl = {
    enable = true;
    driSupport = true;
  };
  
  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    dina-font
    proggyfonts
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
