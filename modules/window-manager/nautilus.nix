{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.window-manager.nautilus;
in
{
  config = lib.mkIf cfg {
    home.packages = with pkgs; [
      catppuccin-gtk
      nautilus
      gvfs
      gnome-themes-extra
    ];
    catppuccin.gtk.icon.enable = true;
    gtk = {
      enable = true;
      colorScheme = "dark";
      theme = {
        name = "catppuccin-frappe-blue-standard";
        package = pkgs.catppuccin-gtk;
      };
      gtk4 = {
        enable = true;
        theme = {
          name = "catppuccin-frappe-blue-standard";
          package = pkgs.catppuccin-gtk;
        };
      };
      font = {
        name = "Fira Code";
        size = 14;
      };
    };
  };
}
