{pkgs, ...}: 
{
  home.packages = with pkgs; [
    fnm
    # Keep pnpm and yarn as they work with any Node.js version managed by fnm
    nodePackages.pnpm
    nodePackages.yarn
  ];

  programs.fish = {
    enable = true;
    generateCompletions = true;
    
    # Initialize fnm (Fast Node Manager)
    interactiveShellInit = ''
      # Initialize fnm
      ${pkgs.fnm}/bin/fnm env --shell fish | source
      
      # Add pnpm and yarn to PATH (they work with any Node.js version managed by fnm)
      set -gx PATH $PATH ${pkgs.nodePackages.pnpm}/bin
      set -gx PATH $PATH ${pkgs.nodePackages.yarn}/bin
    '';
  };
}
