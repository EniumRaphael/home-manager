{
  inputs,
  osConfig ? null,
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.application.thunderbird;
  isStandAlone = osConfig != null && osConfig ? age;
in
{
  config = lib.mkIf cfg {
    accounts.email.accounts = {
      enium = {
        address = "raphael@enium.eu";
        userName = "raphael@enium.eu";
        realName = "Raphael Parodi";
        primary = true;

        imap = {
          host = "imap.exemple.com";
          port = 993;
          tls.enable = true;
        };

        smtp = {
          host = "smtp.exemple.com";
          port = 465;
          tls.enable = true;
        };

        passwordCommand =
          if isStandAlone then
            "cat ${osConfig.age.secrets."mail-enium-password".path}"
          else
            "echo 'osConfig non disponible en standalone'";

        thunderbird = {
          enable = true;
          profiles = [
            "raphael"
          ];
        };
      };
      perso = {
        address = "raphael@parodi.pro";
        userName = "raphael@parodi.pro";
        realName = "Raphael Parodi";
        primary = true;

        imap = {
          host = "imap.exemple.com";
          port = 993;
          tls.enable = true;
        };

        smtp = {
          host = "smtp.exemple.com";
          port = 465;
          tls.enable = true;
        };

        passwordCommand =
          if isStandAlone then
            "cat ${osConfig.age.secrets."mail-perso-password".path}"
          else
            "echo 'osConfig non disponible en standalone'";

        thunderbird = {
          enable = true;
          profiles = [
            "raphael"
          ];
        };
      };
      icloud = {
        address = "parodi.raphael@icloud.com";
        userName = "parodi.raphael@icloud.com";
        realName = "Raphael Parodi";
        primary = true;

        imap = {
          host = "imap.exemple.com";
          port = 993;
          tls.enable = true;
        };

        smtp = {
          host = "smtp.exemple.com";
          port = 465;
          tls.enable = true;
        };

        passwordCommand =
          if isStandAlone then
            "cat ${osConfig.age.secrets."mail-icloud-password".path}"
          else
            "echo 'osConfig non disponible en standalone'";

        thunderbird = {
          enable = true;
          profiles = [
            "raphael"
          ];
        };
      };
    };

    programs.thunderbird = {
      enable = true;
      profiles.default = {
        isDefault = true;
        settings = {
          "mail.spellcheck.inline" = true;
          "mailnews.default_sort_order" = 2;
          "mail.compose.autosave" = true;
        };
      };
    };
  };
}
