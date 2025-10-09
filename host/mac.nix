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
    homeDirectory = "/Users/raphael";
    stateVersion = "24.05";
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  nixpkgs.config.allowUnfree = true;

  imports = [
    cyber
    dev
    package
    zsh
  ];

  application = {
    cava = true;
    cider = false;
    element = true;
    enable = true;
    evince = false;
    fonts = true;
    imv = false;
    kitty = true;
    obs = false;
    obsidian = false;
    openvpn = true;
    prismlauncher = true;
    slack = true;
    ungoogled = false;
    teamspeak = false;
    vesktop = true;
    vlc = false;
    wireshark = true;
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

  cyber = {
    tui = true;
    gui = true;
  };

  catppuccin = {
    enable = true;
    accent = "mauve";
    flavor = "mocha";
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [ "FiraCode Nerd Font" ];
      sansSerif = [ "FiraCode Nerd Font" ];
      monospace = [ "FiraCode Nerd Font" ];
      emoji = [ "FiraCode Nerd Font" ];
    };
  };
  programs.home-manager.enable = true;
}
