{ inputs, config, pkgs, lib, ... }:

let cfg = config.window-manager.rofi;
in {
  config = lib.mkIf cfg {
    catppuccin.rofi.enable = true;
    programs.rofi = {
      enable = true;
      extraConfig = {
        modi = "run,drun,window";
        icon-theme = "Oranchelo";
        show-icons = true;
        terminal = "kitty";
        drun-display-format = "{icon} {name}";
        location = 0;
        disable-history = false;
        hide-scrollbar = true;
        display-drun = "   Apps ";
        display-run = "   Run ";
        display-window = " 󰕰  Window";
        display-Network = " 󰤨  Network";
        sidebar-mode = true;
      };
    };
  };
}
