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

  mailSecrets = [
    {
      label = "Password mail Enium";
      service = "imap-enium";
      user = "raphael@enium.eu";
      secretName = "mail-enium-password";
    }
    {
      label = "Password mail Perso";
      service = "imap-perso";
      user = "raphael@parodi.pro";
      secretName = "mail-perso-password";
    }
    {
      label = "Password mail iCloud";
      service = "imap-icloud";
      user = "parodi.raphael@icloud.com";
      secretName = "mail-icloud-password";
    }
  ];

  storeSecretScript = lib.concatMapStringsSep "\n" (s: ''
    store_secret "${s.label}" "${s.service}" "${s.user}" "${osConfig.age.secrets.${s.secretName}.path}"
  '') mailSecrets;
in
{
  config = lib.mkIf cfg {

    home.activation.loadMailSecrets = lib.mkIf isStandAlone (
      config.lib.dag.entryAfter [ "writeBoundary" ] ''
        set -eu

        store_secret() {
          local label="$1"
          local service="$2"
          local user="$3"
          local secretFile="$4"

          if [ ! -r "$secretFile" ]; then
            echo "⚠️  Secret introuvable ou illisible: $secretFile" >&2
            return 0
          fi

          # Vérifie si le secret existe déjà et est identique — évite un store inutile
          local current
          current="$(${pkgs.libsecret}/bin/secret-tool lookup service "$service" user "$user" 2>/dev/null || true)"
          local wanted
          wanted="$(${pkgs.coreutils}/bin/tr -d '\n' < "$secretFile")"

          if [ "$current" = "$wanted" ]; then
            echo "✔ Secret déjà à jour: $service ($user)"
            return 0
          fi

          if ! printf '%s' "$wanted" | \
              ${pkgs.libsecret}/bin/secret-tool store --label="$label" \
                service "$service" user "$user" 2>/tmp/secret-tool-err.log; then
            echo "⚠️  Échec du stockage du secret $service ($user)" >&2
            cat /tmp/secret-tool-err.log >&2 || true
          else
            echo "✔ Secret stocké: $service ($user)"
          fi
        }

        # On tente seulement si un daemon secret (dbus + org.freedesktop.secrets) répond
        if ${pkgs.dbus}/bin/dbus-send --session --dest=org.freedesktop.secrets \
            --print-reply /org/freedesktop/secrets \
            org.freedesktop.DBus.Peer.Ping >/dev/null 2>&1; then

          ${storeSecretScript}
        else
          echo "⚠️  Service D-Bus secrets non disponible, secrets non stockés" >&2
        fi
      ''
    );

    accounts.email.accounts = {
      Enium = {
        address = "raphael@enium.eu";
        userName = "raphael@enium.eu";
        realName = "Raphael Parodi";
        primary = true;

        imap = {
          host = "imap.migadu.com";
          port = 993;
          tls.enable = true;
        };

        smtp = {
          host = "smtp.migadu.com";
          port = 465;
          tls.enable = true;
        };

        thunderbird = {
          enable = true;
          profiles = [ "raphael" ];
        };
      };

      Perso = {
        address = "raphael@parodi.pro";
        userName = "raphael@parodi.pro";
        realName = "Raphael Parodi";
        primary = false;

        imap = {
          host = "ssl0.ovh.net";
          port = 993;
          tls.enable = true;
        };

        smtp = {
          host = "ssl0.ovh.net";
          port = 465;
          tls.enable = true;
        };

        thunderbird = {
          enable = true;
          profiles = [ "raphael" ];
        };
      };

      iCloud = {
        address = "parodi.raphael@icloud.com";
        userName = "parodi.raphael@icloud.com";
        realName = "Raphael Parodi";
        primary = false;

        imap = {
          host = "imap.mail.me.com";
          port = 993;
          tls.enable = true;
        };

        smtp = {
          host = "smtp.mail.me.com";
          port = 587;
          tls.enable = true;
        };

        thunderbird = {
          enable = true;
          profiles = [ "raphael" ];
        };
      };
    };

    programs.thunderbird = {
      enable = true;
      profiles.raphael = {
        isDefault = true;
        settings = {
          "mail.spellcheck.inline" = true;
          "mailnews.default_sort_order" = 2;
          "mail.compose.autosave" = true;
          "mail.shell.checkDefaultClient" = false;
        };
      };
    };
  };
}
