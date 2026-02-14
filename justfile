#!/usr/bin/env just --working-directory ./ --justfile

default:
  @just --list

# Darwin: mbp (macOS)
# Repo: github:3nln/nix-config

#     _   ___      ____  _____
#    / | / (_)  __/ __ \/ ___/
#   /  |/ / / |/_/ / / /\__ \
#  / /|  / />  </ /_/ /___/ /
# /_/ |_/_/_/|_|\____//____/

# Update inputs + switch (run on the target machine)
darwin-update-local:
    sudo nix run nix-darwin -- switch --flake .#mbp --upgrade

darwin-update-repo:
    sudo nix run nix-darwin -- switch --flake github:3nln/nix-config#mbp --upgrade

#   ______            __
#  /_  __/___  ____  / /____
#   / / / __ \/ __ \/ / ___/
#  / / / /_/ / /_/ / (__  )
# /_/  \____/\____/_/____/


switch-darwin:
    sudo nix run nix-darwin -- switch --flake .#mbp --show-trace

#   ______     __
#  / __ ) \   / /
# / __  \ \ / /
# / /_/ / \ V /
# /_____/   \_/

build-darwin:
    nix build .#darwinConfigurations.mbp.config.system.build.toplevel --show-trace

#   _______________
#  < dev & inspect >
#   ---------------
#        \   ^__^
#         \  (oo)\_______
#            (__)\       )\/\
#                ||----w |
#                ||     ||

format:
    nix fmt

test:
    nix flake check --all-systems --show-trace
