{
  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrains Mono";
      size = 18;
    };

    extraConfig = ''
       include ~/.config/kitty/themes/OneDark-Pro.conf
    '';


    settings = {
      # Window appearance
      background_opacity = "0.95";
      cursor_shape = "beam";
      cursor_blink_interval = "0.5";

      # Scrollback
      scrollback_lines = "10000";

      # Tab bar
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      active_tab_foreground = "#ffffff";
      active_tab_background = "#61afef";
      inactive_tab_foreground = "#888888";
      inactive_tab_background = "#2c313c";

      # Clipboard and mouse
      copy_on_select = "yes";
      paste_from_selection = "yes";
      mouse_hide_wait = "3";

      # Padding
      window_padding_width = "10";
    };

    keybindings = {
      "ctrl+shift+t" = "new_tab";
      "ctrl+shift+w" = "close_tab";
      "ctrl+shift+left" = "previous_tab";
      "ctrl+shift+right" = "next_tab";
    };
  };
}
