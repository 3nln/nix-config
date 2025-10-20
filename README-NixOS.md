# NixOS Configuration

This directory contains your NixOS system configuration managed with Nix flakes.

## Configuration Overview

### System Configuration (`nixos/configuration.nix`)
- **Hostname**: `neo-nixos`
- **User**: `neo` with sudo access and essential groups
- **Desktop Environment**: GNOME (with alternatives for KDE Plasma and XFCE)
- **Bootloader**: systemd-boot (with GRUB alternative)
- **Services**: NetworkManager, Bluetooth, Docker, SSH, printing, etc.

### Hardware Configuration (`nixos/hardware-configuration.nix`)
- **Platform**: x86_64-linux
- **File Systems**: Ext4 root, VFAT boot
- **Power Management**: Enabled
- **CPU Microcode**: Intel updates enabled

## Essential Packages Included

### Basic Utilities
- vim, nano, wget, curl, git, htop, tree
- unzip, zip, p7zip, unrar

### Development Tools
- gcc, gdb, make, cmake, pkg-config

### Network Tools
- NetworkManager, nmap, tcpdump

### System Utilities
- lshw, pciutils, usbutils, dmidecode

### Terminal & File Management
- alacritty, ranger, nnn

## Services Enabled

- **NetworkManager**: Network management
- **Bluetooth**: Audio and device connectivity
- **Docker**: Containerization
- **SSH**: Remote access (key-based authentication)
- **Printing**: CUPS printing system
- **Timesyncd**: Time synchronization
- **Auto-upgrade**: Automatic system updates (without reboot)

## Installation Instructions

### 1. Generate Hardware Configuration
```bash
# Boot from NixOS installation media
sudo nixos-generate-config --show-hardware-config > /mnt/etc/nixos/hardware-configuration.nix
```

### 2. Update Hardware Configuration
Edit `nixos/hardware-configuration.nix` and replace the placeholder UUIDs with actual device UUIDs from your system.

### 3. Build and Install
```bash
# Build the configuration
sudo nixos-rebuild build --flake .#neo

# Install the configuration
sudo nixos-rebuild switch --flake .#neo
```

### 4. Set Root Password
```bash
sudo passwd root
```

## Post-Installation Setup

### 1. Add SSH Keys
Edit `nixos/configuration.nix` and add your SSH public keys to the `openssh.authorizedKeys.keys` list.

### 2. Choose Desktop Environment
The configuration includes GNOME by default. To switch to KDE Plasma or XFCE:
1. Comment out the GNOME configuration
2. Uncomment your preferred desktop environment
3. Rebuild: `sudo nixos-rebuild switch --flake .#neo`

### 3. Install Additional Packages
Add packages to `environment.systemPackages` in `nixos/configuration.nix` or use `nix-env` for user-specific packages.

## Common Commands

### System Management
```bash
# Rebuild and switch to new configuration
sudo nixos-rebuild switch --flake .#neo

# Test configuration without applying
sudo nixos-rebuild test --flake .#neo

# Rollback to previous generation
sudo nixos-rebuild switch --rollback

# List all generations
nix-env --list-generations --profile /nix/var/nix/profiles/system
```

### Package Management
```bash
# Search for packages
nix search nixpkgs package-name

# Install package temporarily
nix-shell -p package-name

# Install package permanently (add to configuration)
# Edit nixos/configuration.nix and rebuild
```

### Flake Commands
```bash
# Update flake inputs
nix flake update

# Show flake information
nix flake show

# Format Nix files
nix fmt
```

## Configuration Structure

```
nixos/
├── configuration.nix          # Main system configuration
├── hardware-configuration.nix # Hardware-specific settings
└── README-NixOS.md           # This file
```

## Troubleshooting

### Boot Issues
- Check `hardware-configuration.nix` for correct device UUIDs
- Verify bootloader configuration matches your system (UEFI vs BIOS)

### Network Issues
- Ensure NetworkManager is enabled
- Check wireless regulatory database if using WiFi

### Audio Issues
- Verify PulseAudio is enabled
- Check user is in `audio` group

### Permission Issues
- Ensure user is in appropriate groups (`wheel`, `audio`, `video`, etc.)

## Next Steps

1. **Customize**: Modify `nixos/configuration.nix` to suit your needs
2. **Add Modules**: Create custom modules in `modules/nixos/`
3. **Home Manager**: Consider using Home Manager for user-specific configurations
4. **Backup**: Set up system backup and snapshot strategies
5. **Security**: Review and harden security settings as needed

## Resources

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [NixOS Wiki](https://nixos.wiki/)
- [Nix Pills](https://nixos.org/guides/nix-pills/)
- [NixOS Configuration Search](https://search.nixos.org/)
