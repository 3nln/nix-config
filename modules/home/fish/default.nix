{pkgs, ...}: {
  programs.fish = {
    enable = true;
    generateCompletions = true;

    interactiveShellInit = ''
      # Add Nix system and user profile bin directories
      set -gx PATH /run/current-system/sw/bin $PATH
      set -gx PATH /nix/var/nix/profiles/default/bin $PATH
      set -gx PATH /etc/profiles/per-user/$USER/bin $PATH

      # Add Cursor CLI and other local binaries
      set -gx PATH $HOME/.local/bin $PATH

      # Add npm global bin directory
      set -gx NPM_CONFIG_PREFIX $HOME/.npm-global
      set -gx PATH $NPM_CONFIG_PREFIX/bin $PATH

      # Add pnpm global bin directory
      set -gx PNPM_HOME $HOME/Library/pnpm
      set -gx PATH $PNPM_HOME $PATH
    '';
  };
}
