{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.application.ghostty;
  font_size = if pkgs.stdenv.hostPlatform.isDarwin then 14 else 12;
in
{
  config = lib.mkIf cfg {
    home.packages = with pkgs; [
      fira-code
    ];

    programs.ghostty = {
      enable = true;
      systemd.enable = true;
      settings = {
        font-family = "Fira Code";
        font-size = font_size;
        font-feature = [
          "+calt"
          "+liga"
          "+dlig"
        ];
        confirm-close-surface = false;
        window-decoration = false;
        term = "xterm-256color";
        installVimSyntax = true;
        enableZshIntegration = true;
      };
    };

    catppuccin.ghostty.enable = true;
  };
}
