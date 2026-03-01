{
  config,
  lib,
  pkgs,
  ...
}: let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
  flakePath = "${config.home.homeDirectory}/Desktop/nix";
  darwinFlake = "${flakePath}#mbp";
  linuxFlake = "${flakePath}#nixos";
  attrsToCommand = attrs: pkgs.lib.mapAttrsToList (key: content: pkgs.writeShellScriptBin key content) attrs;
in {
  home.packages = attrsToCommand (
    (lib.optionalAttrs isDarwin {
      nixrebuild = "git -C ${flakePath} add . && sudo darwin-rebuild switch --flake ${darwinFlake} --impure $1";
      nixcleanup = "nix store gc";
    })
    // (lib.optionalAttrs isLinux {
      nixrebuild = "git -C ${flakePath} add . && home-manager switch --flake ${linuxFlake} $1";
      nixcleanup = "nix-collect-garbage -d && nix store gc";
    })
    // {
      nixupgrade = "nix flake update --flake ${flakePath} $1 && nixrebuild";
      nixpull = "cd ${flakePath} && git pull && cd -";
      nixpush = "cd ${flakePath} && git add . && git commit -m \"automatically updated by nixpush\" && git push && cd -";
      setupskills = "cd ${flakePath} && mkdir -p .github/skills && npx skills add vercel-labs/agent-skills";
    }
  );
}
