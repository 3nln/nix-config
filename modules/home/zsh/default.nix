{
  config,
  pkgs,
  lib,
  ...
}: {
  # To manage ZSHThemes.json from this repo, uncomment and add the file to this directory:
  # home.file."ZSHThemes.json" = { source = ./ZSHThemes.json; };

  programs.zsh = {
    enable = true;

    # Built-in autosuggestion (handles loading order correctly)
    autosuggestion.enable = true;

    # Oh My Zsh
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      # plugins = [ "git" ];
    };

    # External plugins – fast-syntax-highlighting MUST be last
    plugins = [
      {
        name = "zsh-autocomplete";
        src = pkgs.zsh-autocomplete;
      }
      {
        # Must be sourced last for correct behavior
        name = "fast-syntax-highlighting";
        src = pkgs.zsh-fast-syntax-highlighting;
      }
    ];

    initContent = ''
      # oh-my-posh prompt (skip in Apple Terminal - reserved for Ghostty/other terms)
      if [ "$TERM_PROGRAM" != "Apple Terminal" ] && [ -f "''${HOME}/ZSHThemes.json" ]; then
        eval "$(${pkgs.oh-my-posh}/bin/oh-my-posh init zsh --config "''${HOME}/ZSHThemes.json")"
      fi

      export TERM=xterm-256color

      # fnm — Node.js version manager (cross-platform)
      eval "$(${pkgs.fnm}/bin/fnm env --use-on-cd --shell zsh)"
    '';
  };

  home.packages = [pkgs.oh-my-posh pkgs.fnm];
}
