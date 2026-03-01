{
  pkgs,
  nix-vscode-extensions,
  ...
}: let
  # Use pkgs.vscode on both platforms — no Homebrew dependency
  vscodePackage = pkgs.vscode;
  vscodeMarketplace = nix-vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}.vscode-marketplace;
in {
  programs.vscode = {
    enable = true;
    package = vscodePackage;

    profiles = {
      default = {
        userSettings = {
          "files.autoSave" = "afterDelay";
          "editor.fontSize" = 16;
          "window.zoomLevel" = -0.5;
          "editor.fontFamily" = "JetBrains Mono, monospace";
          "editor.fontLigatures" = true;
          "editor.formatOnSave" = true;
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
          "workbench.colorTheme" = "JetBrains New Dark";
          "git.autofetch" = true;

          # "github.copilot.enable" = false;
          # "github.copilot-chat.enable" = false;
          # "chat.disableAIFeatures" = true;

          # --- Terminal settings (zsh with Oh My Zsh from modules/home/zsh) ---
          "terminal.integrated.defaultProfile.linux" = "zsh";
          "terminal.integrated.defaultProfile.osx" = "zsh";

          "terminal.integrated.profiles.linux" = {
            "zsh" = {
              "path" = "${pkgs.zsh}/bin/zsh";
              "args" = [];
            };
          };

          "terminal.integrated.profiles.osx" = {
            "zsh" = {
              "path" = "${pkgs.zsh}/bin/zsh";
              "args" = [];
            };
          };

          # Nix IDE + Nil + Alejandra formatter
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nil";
          "alejandra.program" = "${pkgs.alejandra}/bin/alejandra";
          "[nix]" = {
            "editor.defaultFormatter" = "kamadorueda.alejandra";
            "editor.formatOnPaste" = true;
            "editor.formatOnSave" = true;
            "editor.formatOnType" = false;
          };
        };

        extensions = with vscodeMarketplace; [
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

          kamadorueda.alejandra
          jnoortheen.nix-ide
          bbenoist.nix

          rust-lang.rust-analyzer
          bungcip.better-toml
          tamasfe.even-better-toml
          dustypomerleau.rust-syntax
        ];
      };
    };
  };

  # Nil language server + Alejandra formatter (full path for VSCode GUI which lacks nix PATH)
  home.packages = with pkgs; [
    nil
    alejandra
  ];
}
