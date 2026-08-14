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
    hytale = true;
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
        "DP-1, 3440x1440@175.00000, 0x0, 1, transform, 0"
        ", prefered, auto, 1"
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
    enable = pkgs.stdenv.hostPlatform.isLinux;
    defaultFonts = {
      serif = [ "Fira Code" ];
      sansSerif = [ "Fira Code" ];
      monospace = [ "Fira Code" ];
      emoji = [ "Fira Code" ];
    };
  };

  programs.home-manager.enable = true;
}
