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
        {
          output = "eDP-1";
          mode = "2560x1600@165.00000";
          position = "0x0";
          scale = 1.6;
        }
        {
          output = "DVI-I-1";
          mode = "1920x1080@60.00000";
          position = "-1080x-1080";
          scale = 1;
          transform = 1;
        }
        {
          output = "DVI-I-2";
          mode = "1920x1080@60.00000";
          position = "-1080x-1080";
          scale = 1;
          transform = 1;
        }
        {
          output = "DP-3";
          mode = "1920x1080@60.00000";
          position = "0x-1080";
          scale = 1;
        }
        {
          output = "";
          mode = "preferred";
          position = "auto";
          scale = 1;
        }
      ];
      workspaces = [
        {
          workspace = "1";
          monitor = "DP-3";
          default = true;
        }
        {
          workspace = "2";
          monitor = "DP-3";
        }
        {
          workspace = "3";
          monitor = "DP-3";
        }
        {
          workspace = "4";
          monitor = "DP-3";
        }
        {
          workspace = "5";
          monitor = "DP-3";
        }
        {
          workspace = "6";
          monitor = "DVI-I-1";
        }
        {
          workspace = "7";
          monitor = "DVI-I-1";
        }
        {
          workspace = "8";
          monitor = "DVI-I-1";
        }
        {
          workspace = "9";
          monitor = "DVI-I-1";
        }
        {
          workspace = "10";
          monitor = "DVI-I-1";
        }
        {
          workspace = "6";
          monitor = "DVI-I-2";
        }
        {
          workspace = "7";
          monitor = "DVI-I-2";
        }
        {
          workspace = "8";
          monitor = "DVI-I-2";
        }
        {
          workspace = "9";
          monitor = "DVI-I-2";
        }
        {
          workspace = "10";
          monitor = "DVI-I-2";
        }
        {
          workspace = "11";
          monitor = "DP-3";
          no_border = true;
          no_rounding = true;
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
