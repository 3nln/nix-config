{ ... }:
{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = ./logo;
        padding = {
          top = 3;
          right = 5;
          left = 3;
        };
      };
      display = {
        size = {
          binaryPrefix = "si";
        };
      };
      modules = [
        {
          type = "datetime";
          key = "Date";
          format = "{1}-{3}-{11}";
        }
        "title"
        "separator"
        "os"
        "host"
        "kernel"
        "uptime"
        "packages"
        "shell"
        "display"
        "de"
        "wm"
        "wmtheme"
        "theme"
        "icons"
        "font"
        "cursor"
        "terminal"
        "terminalfont"
        "cpu"
        "gpu"
        "memory"
        "swap"
        "disk"
        "localip"
        "battery"
        "poweradapter"
        "locale"
        "break"
        "colors"
      ];
    };
  };
}
