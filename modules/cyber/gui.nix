{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.cyber.gui;
in
{
  config = lib.mkIf cfg {
    home = {
      packages = with pkgs; [ ] ++ (if pkgs.stdenv.isLinux then [ ] else [ ]);
    };
  };
}
