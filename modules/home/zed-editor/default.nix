{
  pkgs,
  lib,
  ...
}: let
  settings = {
    auto_update = false;
    disable_ai = true;

    auto_install_extensions = {
      nix = true;
      html = true;
      php = true;
      toml = true;
      git-firefly = true;
      sql = true;
      vue = true;
      emmet = true;
      material-icon-theme = true;
      biome = true;
      prisma = true;
      vscode-dark-plus = true;
      env = true;
      live-server = true;
      jetbrains-new-ui-icons = true;
      nextjs-react-snippets = true;
      react-snippets = true;
      react-typescript-snippets = true;
      scss = true;
      vscode-dark-modern = true;
      json5 = true;
      dockerfile = true;
      docker-compose = true;
    };

    telemetry = {
      metrics = false;
      diagnostics = false;
    };

    show_edit_predictions = false;

    node = {
      path = lib.getExe pkgs.nodejs;
      npm_path = lib.getExe' pkgs.nodejs "npm";
    };

    languages = {
      Markdown = {
        format_on_save = "on";
        use_on_type_format = true;
        remove_trailing_whitespace_on_save = true;
      };

      Nix = {
        formatter = "language_server";
        language_servers = [
          "nixd"
          "!nil"
        ];
      };

      TypeScript = {
        language_servers = [
          "typescript-language-server"
          "deno"
          "!vtsls"
          "!eslint"
        ];
        formatter = "language_server";
      };

      TSX = {
        language_servers = [
          "typescript-language-server"
          "deno"
          "!eslint"
          "!vtsls"
        ];
        formatter = "language_server";
      };
    };

    collaboration_panel = {
      button = false;
    };

    icon_theme = "VSCode Great Icons Theme";
    autosave = "on_focus_change";

    agent = {
      enabled = false;
    };

    chat_panel = {
      button = "never";
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
      shell = {
        program = "fish";
      };
      alternate_scroll = "off";
      blinking = "off";
      copy_on_select = false;
      dock = "bottom";
      detect_venv = {
        on = {
          directories = [
            ".env"
            "env"
            ".venv"
            "venv"
          ];
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

      nixd = {
        binary = {
          ignore_system_version = false;
        };
        settings = {
          formatting = {
            command = [
              "alejandra"
            ];
          };
          diagnostic = {
            suppress = [
              "sema-extra-with"
              "sema-extra-rec"
            ];
          };
        };
      };

      rust-analyzer = {
        binary = {
          ignore_system_version = false;
        };
        initialization_options = {
          check = {
            command = "clippy";
          };
        };
      };
    };
  };
in {
  # Zed binary keladi Homebrew cask'dan (modules/darwin/homebrew.nix).
  # Nix settings.json ni boshqaradi, extensions Zed o'zi auto_install_extensions
  # orqali ishga tushganda avtomatik o'rnatadi.
  home.file.".config/zed/settings.json".text = builtins.toJSON settings;
}
