{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.window-manager.hyprpaper;
  image = pkgs.fetchurl {
    url = "https://www.baltana.com/files/wallpapers-20/Cyberpunk-Pixel-Art-Wallpaper-HD-49317.jpg";
    sha256 = "sha256-dv5jHAfqJjvl6an5Xl8lMr7xlpvM5F8OrDMRYy/wOSU=";
  };
  wallpaperPath = "/home/${config.home.username}/Pictures/wallpaper.png";
in
{
  config = lib.mkIf cfg {
    home.packages = with pkgs; [
      hyprpaper
    ];
    home.file."Pictures/wallpaper.png".source = image;
    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = true;
        splash = false;

        preload = [ wallpaperPath ];

        wallpaper = [
          {
            path = "/home/${config.home.username}/Pictures/wallpaper.png";
            monitor = "DP-2";
          }
          {
            path = "/home/${config.home.username}/Pictures/wallpaper.png";
            monitor = "HDMI-A-1";
          }
        ];
      };
    };
  };
}
