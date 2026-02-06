{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.window-manager.thunar;
in
{
  config = lib.mkIf cfg {
    home.packages = with pkgs; [
      gvfs
      thunar
      thunar-archive-plugin
      thunar-volman
      tumbler
      xfconf
    ];
  };
}
