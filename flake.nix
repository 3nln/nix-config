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
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
      nix-vscode-extensions,
    }:
    let
      macSystem = "aarch64-darwin";
      linuxSystem = "x86_64-linux";
      overlays = [
        nix-vscode-extensions.overlays.default
      ];
    in
    {
      # macos
      darwinConfigurations."mbp" = nix-darwin.lib.darwinSystem {
        modules = [
          {
            nixpkgs = {
              hostPlatform = macSystem;
              overlays = overlays;
              config.allowUnfree = true;
            };
            nix.settings.experimental-features = "nix-command flakes";
            environment.systemPackages =
              with import nixpkgs {
                system = macSystem;
                config = {
                  allowUnfree = true;
                  allowUnfreePredicate = _: true;
                  allowUnsupportedSystem = true;
                  allowBroken = true;
                };
              }; [
                kitty
                fastfetch
                telegram-desktop
                fish
                firefox
                zed-editor
                vscode
                flameshot
                vlc
                postman
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
                imports = [
                  ./modules/programs/kitty.nix
                  ./modules/programs/zed-editor.nix
                  ./modules/programs/vscode.nix
                ];
              };
            };
          }
        ];
      };

      # arch
      homeConfigurations."neo" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = linuxSystem;
          overlays = overlays;
          config.allowUnfree = true;
        };

        modules = [
          # ./modules/programs/kitty.nix
          ./modules/programs/zed-editor.nix
          ./modules/programs/vscode.nix
          (
            { pkgs, ... }:
            {
              home.username = "nnolan";
              home.homeDirectory = "/home/nnolan";
              home.stateVersion = "24.05";
              # home.packages = [
              #   pkgs.kitty
              # ];
            }
          )
        ];
      };
    };
}
