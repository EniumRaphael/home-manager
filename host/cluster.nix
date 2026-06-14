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
    username = "rparodi";
    homeDirectory = "/home/rparodi";
    stateVersion = "24.05";
    sessionVariables = {
      ZED_ALLOW_EMULATED_GPU = 1;
      EDITOR = "nvim";
    };
  };

  nixpkgs.config.allowUnfree = true;

  imports = [
    dev
    package
    zsh
  ];

  application = {
    cava = false;
    cider = false;
    element = false;
    enable = false;
    evince = false;
    fonts = false;
    imv = false;
    kitty = true;
    obs = false;
    obsidian = false;
    openvpn = false;
    minecraft = false;
    slack = false;
    ungoogled = false;
    vesktop = false;
    teamspeak = false;
    vlc = false;
    zed = false;
    zen = true;
  };

  dev = {
    enable = true;
    language = {
      c-cpp = false;
      rust = false;
    };
  };

  catppuccin = {
    enable = true;
    autoEnable = true;
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
}
