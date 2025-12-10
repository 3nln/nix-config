# Reusable system packages module
{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    treefmt
    alejandra
    fastfetch
    # Node.js and React development tools
    nodejs
    nodePackages.yarn
    nodePackages.pnpm
    nodePackages.typescript
    nodePackages.typescript-language-server
  ];
}
