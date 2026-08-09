{
  system,
  inputs,
  config,
  pkgs,
  lib,
  gpgFingerprint,
  nixvim,
  orca-slicer-pkg,
  zen-browser,
  ...
}:

let
  dev = import ../modules/dev/default.nix {
    inherit
      inputs
      config
      pkgs
      lib
      nixvim
      ;
  };
  package = import ../modules/packages/default.nix {
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
  window-manager = import ../modules/window-manager/default.nix {
    inherit
      inputs
      config
      pkgs
      lib
      ;
  };
  zsh = import ../modules/shell/default.nix {
    inherit
      inputs
      config
      pkgs
      lib
      gpgFingerprint
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
    dev
    package
    window-manager
    zsh
  ];

  application = {
    enable = true;
    bitwarden = true;
    cava = true;
    cider = true;
    element = true;
    evince = true;
    fonts = true;
    imv = true;
    kitty = true;
    hytale = false;
    nextcloud = true;
    obs = true;
    obsidian = true;
    openvpn = true;
    orcaslicer = true;
    minecraft = true;
    slack = true;
    teamspeak = true;
    ungoogled = true;
    vesktop = true;
    vlc = true;
    zed = true;
    zen = true;
  };

  shell = {
    enable = true;
    tools = {
      git = true;
      starship = true;
      tmux = true;
    };
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
      usingAMD = true;
      isLaptop = true;
      monitors = [
        "eDP-1, 2560x1600@165.00000, 0x0, 1.6"
        "DVI-I-1, 1920x1080@60.00000, -1080x-1080, 1, transform, 1"
        "DP-3, 1920x1080@60.00000, 0x-1080, 1"
        ", prefered, auto, 1"
      ];
      workspaces = [
        "1, monitor:DP-3"
        "2, monitor:DP-3"
        "3, monitor:DP-3"
        "4, monitor:DP-3"
        "5, monitor:DP-3"
        "6, monitor:DVI-I-1"
        "7, monitor:DVI-I-1"
        "8, monitor:DVI-I-1"
        "9, monitor:DVI-I-1"
        "10, monitor:DVI-I-1"
        "11, monitor:DP-3, border:false, rounding:false"
      ];
    };
    hyprlock = true;
    hyprpaper = true;
    noctalia = true;
    mako = true;
    nautilus = true;
  };

  catppuccin = {
    enable = true;
    autoEnable = true;
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
