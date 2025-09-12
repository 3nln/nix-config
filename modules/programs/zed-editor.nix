{pkgs, lib, ...}:
{
  program.zed-editor = {
    enabled = true;

    extensions: [
    "nix",
    "html",
    "php",
    "toml",
    "git-firefly",
    "sql",
    "vue",
    "emmet",
    "material-icon-theme",
    "biome",
    "prisma",
    "vscode-dark-plus",
    "env",
    "live-server",
    "jetbrains-new-ui-icons",
    "nextjs-react-snippets",
    "react-snippets",
    "react-typescript-snippets",
    "scss",
    "vscode-dark-modern",
    "json5",
    "dockerfile",
    "docker-compose",
    ];
  }
}
