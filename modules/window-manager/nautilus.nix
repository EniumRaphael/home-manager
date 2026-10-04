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
      file-roller
      gnome-themes-extra
      gvfs
      nautilus
      p7zip
      unrar
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
