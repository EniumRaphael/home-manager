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
    username = "pi";
    homeDirectory = "/home/pi";
    stateVersion = "24.05";
    sessionVariables = {
      ZED_ALLOW_EMULATED_GPU = 1;
      EDITOR = "nvim";
    };
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
    kitty = true;
    obs = false;
    obsidian = true;
    openvpn = true;
    prismlauncher = false;
    slack = false;
    ungoogled = false;
    vesktop = true;
    teamspeak = true;
    vlc = false;
    zed = false;
    zen = true;
  };

  dev = {
    enable = true;
    language = {
      c-cpp = true;
      rust = true;
    };
  };

  cyber = {
    gui = true;
    tui = true;
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

  catppuccin = {
    enable = true;
    accent = "mauve";
    flavor = "mocha";
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [ "Fira Code" ];
      sansSerif = [ "Fira Code" ];
      monospace = [ "Fira Code" ];
      emoji = [ "Fira Code" ];
    };
  };
  programs.home-manager.enable = true;
}
