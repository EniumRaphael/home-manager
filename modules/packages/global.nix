{
  system,
  inputs,
  config,
  pkgs,
  lib,
  orca-slicer-pkg,
  zen-browser,
  ...
}:

let
  cava = import ./cava.nix {
    inherit
      inputs
      config
      pkgs
      lib
      ;
  };
  kitty = import ./kitty.nix {
    inherit
      inputs
      config
      pkgs
      lib
      ;
  };
  cfg = config.application;
in
{
  imports = [
    cava
    kitty
    inputs.zen-browser.homeModules.beta
  ];

  options.application = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the default applications";
    };
    bitwarden = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Bitwarden";
    };
    cider = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Cider Music";
    };
    teamspeak = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable the teamspealk client";
    };
    prismlauncher = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Prism Launcher";
    };
    zed = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Zed Editor";
    };
    obs = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the OBS Studio";
    };
    nextcloud = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the nextcloud client";
    };
    slack = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Slack";
    };
    element = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Element Desktop";
    };
    fonts = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Nerd Fonts";
    };
    orcaslicer = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Obsidian";
    };
    obsidian = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Obsidian";
    };
    openvpn = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the OpenVPN";
    };
    ungoogled = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Ungoogled Chromium";
    };
    vesktop = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Vesktop";
    };
    vlc = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the VLC";
    };
    evince = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the evince";
    };
    imv = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the IMV";
    };
    wireshark = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the wireshark";
    };
    zen = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the zen web browser";
    };
    cava = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the cava audio visualiser";
    };
    kitty = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the kitty terminal emulator";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages =
      with pkgs;
      (if cfg.cider then [ cider-2 ] else [ ])
      ++ (
        if cfg.prismlauncher then
          [
            prismlauncher
            openjdk
          ]
        else
          [ ]
      )
      ++ (
        if cfg.fonts then
          with pkgs.nerd-fonts;
          [
            fira-code
            jetbrains-mono
          ]
        else
          [ ]
      )
      ++ (
        if cfg.element then
          [
            element-desktop
            libsecret
          ]
        else
          [ ]
      )
      ++ (if cfg.nextcloud then [ libsecret ] else [ ])
      ++ (if cfg.obsidian then [ obsidian ] else [ ])
      ++ (if cfg.orcaslicer then [ orca-slicer-pkg ] else [ ])
      ++ (if cfg.openvpn then [ openvpn ] else [ ])
      ++ (if cfg.slack then [ slack ] else [ ])
      ++ (if cfg.ungoogled then [ ungoogled-chromium ] else [ ])
      ++ (if cfg.vesktop then [ vesktop ] else [ ])
      ++ (if cfg.teamspeak then [ teamspeak6-client ] else [ ])
      ++ (if cfg.vlc then [ vlc ] else [ ])
      ++ (if cfg.evince then [ evince ] else [ ])
      ++ (if cfg.imv then [ imv ] else [ ])
      ++ (if cfg.wireshark then [ wireshark-cli ] else [ ])
      ++ (if cfg.zed then [ zed-editor ] else [ ])
      ++ (if cfg.bitwarden then [ bitwarden-desktop ] else [ ]);
    catppuccin = {
      vesktop.enable = cfg.vesktop;
      element-desktop.enable = cfg.element;
      zed.enable = cfg.zed;
    };
    programs = {
      zen-browser = {
        enable = cfg.zen;
        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          bitwarden
          cookie-editor
          darkreader
          foxyproxy-standard
          hacktools
          owasp-penetration-testing-kit
          privacy-badger
          return-youtube-dislikes
          sponsorblock
          ublock-origin
          vimiumc
          violentmonkey
          wappalyzer
          wayback-machine
        ];
        profiles."default" = {
          settings = {
            # UI
            "ui.textScaleFactor" = 120;
            "browser.uidensity" = 1;
            "browser.theme.content-theme" = 0;
            "browser.theme.toolbar-theme" = 0;
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

            # Zen
            "zen.view.compact.enable-at-startup" = true;
            "zen.theme.accent-color" = "#8caaee";
            "zen.tabs.vertical.right-side" = false;

            # Privacy
            "privacy.trackingprotection.enabled" = true;
            "privacy.trackingprotection.socialtracking.enabled" = true;
            "privacy.fingerprintingProtection" = true;
            "privacy.sanitize.sanitizeOnShutdown" = true;
            "privacy.clearOnShutdown.history" = false;
            "privacy.clearOnShutdown.cookies" = false;
            "privacy.clearOnShutdown.cache" = true;
            "privacy.clearOnShutdown.downloads" = false;

            # Telemetry
            "datareporting.healthreport.uploadEnabled" = false;
            "datareporting.policy.dataSubmissionEnabled" = false;
            "toolkit.telemetry.enabled" = false;
            "toolkit.telemetry.unified" = false;
            "browser.ping-centre.telemetry" = false;
            "browser.newtabpage.activity-stream.feeds.telemetry" = false;
            "browser.newtabpage.activity-stream.telemetry" = false;

            # Network
            "network.dns.disablePrefetch" = true;
            "network.prefetch-next" = false;
            "network.http.speculative-parallel-limit" = 0;

            # Passwords
            "signon.rememberSignons" = false;
            "signon.autofillForms" = false;

            # Performance
            "gfx.webrender.all" = true;
            "media.ffmpeg.vaapi.enabled" = true;
            "media.hardware-decoding.force-enabled" = true;

            # Misc
            "browser.shell.checkDefaultBrowser" = false;
            "browser.startup.page" = 3;
            "browser.sessionstore.resume_from_crash" = true;
            "browser.newtabpage.enabled" = false;
            "browser.download.useDownloadDir" = true;
          };
        };
      };

      obs-studio = {
        enable = cfg.obs;
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-backgroundremoval
          obs-pipewire-audio-capture
        ];
      };
    };
    services = {
      gnome-keyring = {
        enable = true;
        components = [ "pkcs11" "secrets" "ssh" ];
      };
      nextcloud-client = {
        enable = cfg.nextcloud;
        startInBackground = true;
      };
    };
  };
}
