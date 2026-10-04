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
      nerd-fonts.fira-code
      fira-code-symbols
    ];

    programs.ghostty = {
      enable = true;
      systemd.enable = true;
      installVimSyntax = true;
      enableZshIntegration = true;
      settings = {
        font-family = "Fira Code";
        font-variation = "wght=400";
        font-size = font_size;
        font-feature = [
          "+calt"
        ];
        confirm-close-surface = false;
        window-decoration = false;
        term = "xterm-256color";
      };
    };

    catppuccin.ghostty.enable = true;
  };
}
