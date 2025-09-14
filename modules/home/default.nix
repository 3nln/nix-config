# Add your reusable home-manager modules to this directory, on their own file (https://wiki.nixos.org/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
#
# Refer to the link below for more options:
# https://nix-community.github.io/home-manager/options.xhtml
{
  fastfetch = import "./fastfetch.nix";
  git = import "./git.nix";
  kitty = import "./kitty.nix";
  ssh = import "./ssh.nix";
  vscode = import "./vscode.nix";
  zed-editor = import "./vscode.nix";
}
