{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    profiles.default = {
      # Extensions
      extensions = with pkgs.vscode-marketplace; [
        jnoortheen.nix-ide
        dbaeumer.vscode-eslint
        dracula-theme.theme-dracula
        formulahendry.auto-rename-tag
        bungcip.better-toml
        dsznajder.es7-react-js-snippets
        dbaeumer.vscode-eslint
        zaaack.markdown-editor
        unifiedjs.vscode-mdx
        arrterian.nix-env-selector
        esbenp.prettier-vscode
        rust-lang.rust-analyzer
        bradlc.vscode-tailwindcss
        tauri-apps.tauri-vscode
        pflannery.vscode-versionlens
        mobalic.jetbrains-new-dark
        jawandarajbir.react-vscode-extension-pack
        pkief.material-icon-theme
      ];

      # User settings
      userSettings = {
        "files.autoSave" = "afterDelay";
        "editor.fontSize" = 18;
        "editor.formatOnSave" = true;
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "workbench.colorTheme" = "JetBrains New Dark";
        "git.autofetch" = true;

        # Nix IDE + Nil
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";
      };
    };
  };

  # Nil language server
  home.packages = with pkgs; [
    nil
  ];
}
