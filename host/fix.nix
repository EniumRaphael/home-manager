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
    stateVersion = "26.05";
    sessionVariables = {
      MAILER = "thunderbird";
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
    ghostty = true;
    thunderbird = true;
    libreoffice = true;
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
        {
          output = "DP-1";
          mode = "3440x1440@175.00000";
          position = "0x0";
          scale = 1;
          transform = 0;
        }
        {
          output = "";
          mode = "preferred";
          position = "auto";
          scale = 1;
        }
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
