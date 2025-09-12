{ pkgs, lib, ... }:
{
  programs.zed-editor = {
    enable = true;

    extensions = [
      "nix"
      "html"
      "php"
      "toml"
      "git-firefly"
      "sql"
      "vue"
      "emmet"
      "material-icon-theme"
      "biome"
      "prisma"
      "vscode-dark-plus"
      "env"
      "live-server"
      "jetbrains-new-ui-icons"
      "nextjs-react-snippets"
      "react-snippets"
      "react-typescript-snippets"
      "scss"
      "vscode-dark-modern"
      "json5"
      "dockerfile"
      "docker-compose"
    ];

    userSettings = {
      icon_theme = "VSCode Great Icons Theme";
      autosave = "on_focus_change";

      agent = {
        enabled = false;
        # default_model = {
        #   provider = "zed.dev";
        #   model = "claude-3-7-sonnet-latest";
        # };
      };

      vim_mode = false;
      ui_font_size = 20;
      buffer_font_size = 20;

      theme = {
        mode = "system";
        light = "One Light";
        dark = "VSCode Dark Modern";
      };

      features = {
        edit_prediction_provider = "none";
        copilot = false;
      };

      edit_predictions = {
        copilot = {
          proxy = null;
          proxy_no_verify = null;
        };
      };

      terminal = {
        shell = "system";
        alternate_scroll = "off";
        blinking = "off";
        copy_on_select = false;
        dock = "bottom";
        detect_venv = {
          on = {
            directories = [ ".env" "env" ".venv" "venv" ];
            activate_script = "default";
          };
        };
        env = {
          TERM = "alacritty";
        };
        font_features = null;
        font_size = 20;
        line_height = "comfortable";
        option_as_meta = false;
        button = false;
        toolbar = {
          title = true;
        };
        working_directory = "current_project_directory";
      };

      lsp = {
        typescript-language-server = {
          initialization_options = {
            preferences = {
              includeInlayParameterNameHints = "all";
              includeInlayParameterNameHintsWhenArgumentMatchesName = true;
              includeInlayFunctionParameterTypeHints = true;
              includeInlayVariableTypeHints = true;
              includeInlayVariableTypeHintsWhenTypeMatchesName = true;
              includeInlayPropertyDeclarationTypeHints = true;
              includeInlayFunctionLikeReturnTypeHints = true;
              includeInlayEnumMemberValueHints = true;
            };
          };
        };
      };
    };
  };
}
