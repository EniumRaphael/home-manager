{
  system,
  inputs,
  config,
  pkgs,
  lib,
  nixvim,
  zen-browser,
  ...
}:

let
  cyber = import ../modules/cyber/global.nix {
    inherit
      inputs
      config
      pkgs
      lib
      nixvim
      ;
  };
  dev = import ../modules/dev/global.nix {
    inherit
      inputs
      config
      pkgs
      lib
      nixvim
      ;
  };
  package = import ../modules/packages/global.nix {
    inherit
      system
      inputs
      config
      pkgs
      lib
      zen-browser
      ;
  };
  window-manager = import ../modules/window-manager/global.nix {
    inherit
      inputs
      config
      pkgs
      lib
      ;
  };
  zsh = import ../modules/shell/zsh.nix {
    inherit
      inputs
      config
      pkgs
      lib
      ;
  };
in
{
  home = {
    username = "raphael";
    homeDirectory = "/home/raphael";
    stateVersion = "24.05";
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  catppuccin = {
    enable = true;
    accent = "mauve";
    flavor = "mocha";
  };

  nixpkgs.config.allowUnfree = true;

  imports = [
    cyber
    dev
    package
    window-manager
    zsh
  ];

  application = {
    enable = true;
    cava = false;
    cider = false;
    element = false;
    evince = false;
    fonts = false;
    imv = false;
    kitty = false;
    obs = false;
    obsidian = false;
    openvpn = true;
    prismlauncher = false;
    slack = false;
    teamspeak = false;
    ungoogled = false;
    vesktop = false;
    vlc = false;
    zed = false;
    zen = false;
  };

  dev = {
    enable = true;
    language = {
      c-cpp = true;
      rust = true;
    };
  };

  window-manager = {
    enable = false;
    hyprland = false;
    hyprpaper = false;
    mako = false;
    rofi = false;
    thunar = false;
    waybar = false;
  };

  fonts.fontconfig = {
    enable = pkgs.stdenv.isLinux;
    defaultFonts = {
      serif = [ "Fira Code" ];
      sansSerif = [ "Fira Code" ];
      monospace = [ "Fira Code" ];
      emoji = [ "Fira Code" ];
    };
  };
  programs.home-manager.enable = true;
}
