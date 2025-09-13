{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    profiles.default = {
      # Extensions
      extensions = with pkgs.vscode-marketplace; [
        jnoortheen.nix-ide
        dbaeumer.vscode-eslint
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
        biomejs.biome
        tauri-apps.tauri-vscode
        pflannery.vscode-versionlens
        mobalic.jetbrains-new-dark
        jawandarajbir.react-vscode-extension-pack
        pkief.material-icon-theme
        donjayamanne.githistory
        wix.vscode-import-cost
        gruntfuggly.todo-tree
        wakatime.vscode-wakatime
        prisma.prisma
        mohsen1.prettify-json
        christian-kohler.npm-intellisense
        fallenmax.mithril-emmet
        unifiedjs.vscode-mdx
        zaaack.markdown-editor
        gogocrow.jsx-beautify
        tamasfe.even-better-toml
        pranaygp.vscode-css-peek
        intellsmi.comment-translate
        naumovs.color-highlight
        formulahendry.auto-close-tag
        steoates.autoimport
        ms-vscode.vscode-typescript-tslint-plugin
        lokalise.i18n-ally
      ];

      # User settings
      userSettings = {
        "files.autoSave" = "afterDelay";
        "editor.fontSize" = 18;
        "editor.formatOnSave" = true;
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "workbench.colorTheme" = "JetBrains New Dark";
        "git.autofetch" = true;

        "github.copilot.enable" = false;
        "github.copilot-chat.enable" = false;
        "chat.disableAIFeatures" = true;

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
