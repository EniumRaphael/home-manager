{
  inputs,
  config,
  pkgs,
  lib,
  gpgFingerprint ? null,
  ...
}:

let
  git = import ./git.nix {
    inherit
      config
      pkgs
      lib
      gpgFingerprint
      ;
  };
  starship = import ./starship.nix { inherit config pkgs lib; };
  tmux = import ./tmux.nix { inherit config pkgs lib; };
  zsh = import ./zsh.nix { inherit config pkgs lib; };
in
{
  imports = [
    git
    starship
    tmux
    zsh
  ];

  options.shell = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable the shell configuration.";
    };

    tools = {
      git = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable the Git configuration.";
      };

      starship = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable the Starship configuration.";
      };

      tmux = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable the Tmux configuration.";
      };
    };
  };
}
