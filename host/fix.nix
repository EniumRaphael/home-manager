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
      primaryMonitor = "HDMI-A-1";
      usingNVIDIA = true;
      monitors = [
        "HDMI-A-1, 1920x1080, 0x0, 1"
        "DP-1, 1920x1080, -1080x-840, 1, transform, 1"
        ", prefered, auto, 1"
      ];
      workspaces = [
          "1, monitor:HDMI-A-1"
          "2, monitor:HDMI-A-1"
          "3, monitor:HDMI-A-1"
          "4, monitor:HDMI-A-1"
          "5, monitor:HDMI-A-1"
          "6, monitor:DP-1"
          "7, monitor:DP-1"
          "8, monitor:DP-1"
          "9, monitor:DP-1"
          "10, monitor:DP-1"
          "11, monitor:HDMI-A-1, border:false, rounding:false"
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
