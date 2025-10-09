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
    url = "https://github.com/zhichaoh/catppuccin-wallpapers/blob/main/misc/cat_bunnies.png?raw=true";
    sha256 = "167ndqbq4mmm486rszvablyykpckaz68djhagskwc5nf187263ia";
  };
in
{
  config = lib.mkIf cfg {
    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        splash_offset = 2.0;

        preload = [ "~/Pictures/wallpaper.png" ];

        wallpaper = [ ",~/Pictures/wallpaper.png" ];
      };
    };
    home = {
      #      packages = with pkgs; [
      #        fetchurl
      #      ];
      file."Pictures/wallpaper.png".source = image;
    };
  };
}
