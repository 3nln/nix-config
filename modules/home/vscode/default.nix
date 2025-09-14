{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    profiles = {
      # Default profile
      default = {
        # User settings
        userSettings = {
          "files.autoSave" = "afterDelay";
          "editor.fontSize" = 18;
          "editor.fontFamily" = "JetBrains Mono, monospace";
          "editor.fontLigatures" = true;
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
          "[nix]" = {
            "editor.defaultFormatter" = "jnoortheen.nix-ide";
          };
        };

        # Extensions
        extensions = with pkgs.vscode-marketplace; [
          dbaeumer.vscode-eslint
          formulahendry.auto-rename-tag
          dsznajder.es7-react-js-snippets
          zaaack.markdown-editor
          unifiedjs.vscode-mdx
          esbenp.prettier-vscode
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
          gogocrow.jsx-beautify
          pranaygp.vscode-css-peek
          intellsmi.comment-translate
          naumovs.color-highlight
          formulahendry.auto-close-tag
          steoates.autoimport
          ms-vscode.vscode-typescript-tslint-plugin
          lokalise.i18n-ally

          jnoortheen.nix-ide
          bbenoist.nix
          arrterian.nix-env-selector

          rust-lang.rust-analyzer
          bungcip.better-toml
          tamasfe.even-better-toml
          dustypomerleau.rust-syntax
        ];
      };
    };

  };

  # Nil language server
  home.packages = with pkgs; [
    nil
  ];
}
