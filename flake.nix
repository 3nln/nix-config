{
  description = "nnix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    # Nix-darwin for macOS systems management
    nix-darwin = {
      url = "github:xinux-org/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    phpuzb-telegram.url = "github:3nln/php-tg-floss";
    portfolio.url = "git+ssh://git@github.com/3nln/portfolio.git";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-darwin,
    nix-vscode-extensions,
    phpuzb-telegram,
    portfolio,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    overlays = import ./overlays {inherit inputs;};
    nixosModules = import ./modules/nixos;
    darwinModules = import ./modules/darwin;
    homeModules = import ./modules/home;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#neo'
    nixosConfigurations = {
      neo = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [
          phpuzb-telegram.nixosModules.phpuzb-telegram
          ./nixos/configuration.nix
        ];
      };

      # Hetzner server configuration
      # Available through 'nixos-rebuild --flake .#hetzner'
      hetzner = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [
           portfolio.nixosModules.server
          ./hosts/hetzner/configuration.nix
        ];
      };
    };

    # macOS konfiguratsiyasi
    darwinConfigurations."mbp" = nix-darwin.lib.darwinSystem {
      specialArgs = {inherit inputs outputs;};
      modules = [
        ./modules/darwin/configuration.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.neo = import ./home.nix;
          home-manager.backupFileExtension = "backup";
        }
      ];
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@neo'
    homeConfigurations."neo" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
        overlays = [
          outputs.overlays.vscode-extensions
        ];
      };
      extraSpecialArgs = {inherit inputs outputs;};
      modules = [
        ./home.nix
      ];
    };
  };
}
