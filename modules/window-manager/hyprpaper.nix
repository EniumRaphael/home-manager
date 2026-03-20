{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.window-manager.hyprpaper;
  verticalWallpaper = pkgs.fetchurl {
    url = "https://github.com/EniumRaphael/dotfiles/blob/master/wallpaper_vertical.png?raw=true";
    sha256 = "sha256-YuxT0+QQb33pcJ12v3lKQEpRT6Ju/ef9+xpWVAAp5sk=";
  };
  horizonWallpaper = pkgs.fetchurl {
    url = "https://github.com/zhichaoh/catppuccin-wallpapers/blob/main/misc/windows-error.jpg?raw=true";
    sha256 = "sha256-Yr31nKWS1yLkxs6GxYQ6jHwKgJ+b9iqPcZbBY0suGLg=";
  };
in
{
  config = lib.mkIf cfg {
    home.packages = with pkgs; [
      hyprpaper
    ];
    home.file."Pictures/vertical.png".source = verticalWallpaper;
    home.file."Pictures/horizontal.png".source = horizonWallpaper;
    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = true;
        splash = false;

        preload = [ "/home/${config.home.username}/Pictures/horizontal.png" ];

        wallpaper = [
          {
            path = "/home/${config.home.username}/Pictures/vertical.png";
            monitor = "DP-2";
          }
          {
            path = "/home/${config.home.username}/Pictures/horizontal.png";
            monitor = "HDMI-A-1";
          }
        ];
      };
    };
  };
}
