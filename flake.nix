{
  description = "nnix config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Nix-darwin for macOS systems management
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Pin for specific packages if needed
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Manages Homebrew installation itself on macOS
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-darwin,
    nixpkgs-stable,
    nix-vscode-extensions,
    nix-homebrew,
  } @ inputs: let
    linuxSystem = "x86_64-linux";
    linuxUser = "nnolan";
    inherit (self) outputs;
    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
    linuxHostname = "nixos";
  in {
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Darwin configuration entrypoint
    darwinConfigurations."mbp" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = {inherit inputs outputs;};
      modules = [
        ./modules/darwin/configuration.nix
        home-manager.darwinModules.home-manager
        nix-homebrew.darwinModules.nix-homebrew
        {
          # Homebrew: install and manage automatically
          nix-homebrew = {
            enable = true;
            enableRosetta = false; # ARM-only (aarch64-darwin / Apple Silicon)
            user = "nnolan";
            autoMigrate = true; # adopt existing /opt/homebrew if present
          };
        }
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            inherit nix-vscode-extensions;
            username = "nnolan";
          };
          home-manager.users.nnolan = ./home.nix;
          home-manager.backupFileExtension = "backup";
        }
      ];
    };

    # Kubuntu (x86_64) — standalone home-manager
    homeConfigurations.${linuxHostname} = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${linuxSystem};
      extraSpecialArgs = {
        inherit inputs outputs nix-vscode-extensions;
        username = linuxUser;
      };
      modules = [
        ./home.nix
        {
          # On Linux (standalone HM), there's no system-level nixpkgs — set here directly.
          nixpkgs.config.allowUnfree = true;
          nixpkgs.config.android_sdk.accept_license = true;
        }
      ];
    };
  };
}
