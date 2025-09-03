{
  description = "nnolan nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let
    macSystem = "aarch64-darwin";
    linuxSystem = "x86_64-linux";

    # configuration = { pkgs, ... }: {
    #   # List packages installed in system profile. To search by name, run:
    #   # $ nix-env -qaP | grep wget
    #   nixpkgs.config.allowUnfree = true;

    #   environment.systemPackages =
    #     [
    #       pkgs.kitty
    #       pkgs.fastfetch
    #       pkgs.fish
    #       pkgs.telegram-desktop
    #       pkgs.firefox
    #       pkgs.zed-editor
    #       pkgs.google-chrome
    #     ];

    #   fonts.packages =
    #   [
    #     pkgs.nerd-fonts.jetbrains-mono
    #   ];

    #   # Necessary for using flakes on this system.
    #   nix.settings.experimental-features = "nix-command flakes";

    #   # Enable alternative shell support in nix-darwin.
    #   # programs.fish.enable = true;

    #   # Set Git commit hash for darwin-version.
    #   system.configurationRevision = self.rev or self.dirtyRev or null;

    #   # Used for backwards compatibility, please read the changelog before changing.
    #   # $ darwin-rebuild changelog
    #   system.stateVersion = 6;

    #   # The platform the configuration will be used on.
    #   nixpkgs.hostPlatform = "aarch64-darwin";
    # };

  in
  {

    # macos
    darwinConfigurations."mbp" = nix-darwin.lib.darwinSystem {
      modules = [ 
        {
          nixpkgs.hostPlatform = macSystem;
          nix.settings.experimental-features = "nix-command flakes";
          environment.systemPackages = with import nixpkgs { system = macSystem; };[
            kitty
            fastfetch
            telegram-desktop
            fish
            firefox
            zed-editor
            # google-chrome
          ];
          system.stateVersion = 6;
           users.users.neo = {
             home = "/Users/neo";
           };
        }
        home-manager.darwinModules.home-manager  
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            users.neo = {
              home.username = "neo";
              home.homeDirectory = "/Users/neo";
              home.stateVersion = "25.05";

              programs.fish.enable = true;
              imports = [ ./modules/programs/kitty.nix ];
            };
          };
        }
       ];
    };


    # arch
    homeConfigurations."neo" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {system = linuxSystem; };

      modules = [
        ./modules/programs/kitty.nix
        ({pkgs, ...}: {
          home.username = "nnolan";
          home.homeDirectory = "/home/nnolan";
          home.stateVersion = "24.05";

          programs.fish.enable = true;

          home.packages = [
            pkgs.kitty
          ];
        })
      ];
    };
  };
}
