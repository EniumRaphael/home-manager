{
  config,
  lib,
  gpgFingerprint,
  ...
}:

let
  cfg = config.shell.tools.git;
in
{
  config = lib.mkIf cfg {
    programs = {
      gpg = lib.mkIf (gpgFingerprint != null) {
        enable = true;
      };
      git = {
        enable = true;
        ignores = [
          ".DS_Store"
          "*.swp"
          "*.swo"
          "*.swm"
          "*.swu"
          "node_modules/"
          ".env"
        ];
        settings = {
          alias = {
            "a" = "add";
            "c" = "commit";
            "d" = "diff";
            "h" = "log --oneline";
            "m" = "commit -m";
            "p" = "push";
            "r" = "restore";
            "s" = "status";
            "br" = "branch";
            "cl" = "clone";
            "co" = "checkout";
            "pf" = "push --force-with-lease";
            "pp" = "pull";
            "rb" = "rebase";
            "ss" = "status --short";
            "rbi" = "rebase -i";
          };
          core = {
            editor = "nvim";
            pager = "bat -p";
          };
          pull = {
            rebase = true;
          };
          push = {
            autoSetupRemote = true;
          };
          user = {
            name = "Raphael Parodi";
            email = "raphael@parodi.pro";
          };
          signing = lib.mkIf (gpgFingerprint != null) {
            key = gpgFingerprint;
            format = "openpgp";
            signByDefault = true;
          };
        };
      };

    };
  };
}
