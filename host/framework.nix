{
  system,
  inputs,
  config,
  pkgs,
  lib,
  nixvim,
  orca-slicer-pkg,
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
      orca-slicer-pkg
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
      ZED_ALLOW_EMULATED_GPU = 1;
      EDITOR = "nvim";
    };
  };

  imports = [
    cyber
    dev
    package
    window-manager
    zsh
  ];

  application = {
    enable = true;
    cava = true;
    cider = true;
    element = true;
    evince = true;
    fonts = true;
    imv = true;
    kitty = true;
    obs = true;
    obsidian = true;
    openvpn = true;
    orcaslicer = true;
    prismlauncher = true;
    slack = true;
    ungoogled = true;
    vesktop = true;
    vlc = true;
    teamspeak = true;
    zed = true;
    zen = true;
  };

  cyber = {
    tui = true;
    gui = true;
  };

  dev = {
    enable = true;
    language = {
      c-cpp = true;
      rust = true;
    };
  };

  window-manager = {
    enable = true;
    hyprland = {
      enable = true;
      primaryMonitor = "eDP-1";
      monitors = [
        "eDP-1, 2560x1600@165.00000, 0x0, 1.6"
        ", prefered, auto, 1"
      ];
    };
    hyprlock = true;
    hyprpaper = true;
    mako = true;
    vicinae = true;
    nautilus = true;
    waybar = true;
  };

  catppuccin = {
    enable = true;
    accent = "mauve";
    flavor = "mocha";
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
