{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:

let
  hyprland = import ./hyprland.nix {
    inherit
      inputs
      config
      pkgs
      lib
      ;
  };
  hyprpaper = import ./hyprpaper.nix {
    inherit
      inputs
      config
      pkgs
      lib
      ;
  };
  mako = import ./mako.nix {
    inherit
      inputs
      config
      pkgs
      lib
      ;
  };
  vicinae = import ./vicinae.nix {
    inherit
      inputs
      config
      pkgs
      lib
      ;
  };
  nautilus = import ./nautilus.nix {
    inherit
      inputs
      config
      pkgs
      lib
      ;
  };
  hyprlock = import ./hyprlock.nix {
    inherit
      inputs
      config
      pkgs
      lib
      ;
  };
  waybar = import ./waybar.nix {
    inherit
      inputs
      config
      pkgs
      lib
      ;
  };

  cfg = config.window-manager;
in
{
  imports = [
    hyprland
    hyprpaper
    mako
    vicinae
    nautilus
    hyprlock
    waybar
  ];

  options.window-manager = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the configuration of the window-manager";
    };
    hyprland = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable the Hyprland configuration";
      };
      primaryMonitor = lib.mkOption {
        type = lib.types.str;
        default = "eDP-1";
        description = "The default monitor for hyprland";
      };
      monitors = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ",preferred,auto,1" ];
        description = "Monitor configuration";
      };
      workspaces = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = "Workspaces configuration";
      };
      isLaptop = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable the laptop";
      };
    };
    hyprlock = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Hyprland configuration";
    };
    hyprpaper = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Hyprpaper configuration";
    };
    mako = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the mako configuration";
    };
    nautilus = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Nautilus configuration";
    };
    vicinae = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Vicinae configuration";
    };
    waybar = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Waybar configuration";
    };
  };

  config =
    lib.mkIf (!config.window-manager.enable) {
      window-manager = {
        hyprland = false;
        hyprpaper = false;
        mako = false;
        vicinae = false;
        waybar = false;
        nautilus = false;
      };
    }
    // lib.mkIf cfg.enable {
      home.packages = with pkgs; [
        grim
        pavucontrol
        slurp
      ];

      catppuccin.accent = "mauve";

      xdg.userDirs = {
        enable = true;
        setSessionVariables = true;
        createDirectories = true;
      };
    };
}
