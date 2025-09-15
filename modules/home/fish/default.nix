{pkgs, ...}: 
{
  programs.fish = {
    enable = true;
    generateCompletions = true;
    
    interactiveShellInit = ''
      # Add Nix profile bin directories to PATH
      set -gx PATH $PATH /etc/profiles/per-user/$USER/bin
      set -gx PATH $PATH /nix/var/nix/profiles/default/bin
      set -gx PATH $PATH /run/current-system/sw/bin
 
      # Add npm global bin directory to PATH
      set -gx PATH $PATH ~/.npm-global/bin
      
      # Set NPM global directory
      set -gx NPM_CONFIG_PREFIX ~/.npm-global
    '';
  };
}