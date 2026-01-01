# This file defines overlays
{ inputs, ... }:
{
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
    portfolio = prev.portfolio.overrideAttrs (oldAttrs: {
      buildInputs = (oldAttrs.buildInputs or []) ++ [
        final.nodejs
      ];
      # Set environment variable to skip font fetching
      preBuild = (oldAttrs.preBuild or "") + ''
        export NEXT_PUBLIC_SKIP_FONTS=true
        # Or patch the layout.tsx to use local fonts instead
      '';
    });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  # VSCode extensions overlay
  vscode-extensions = inputs.nix-vscode-extensions.overlays.default;
}
