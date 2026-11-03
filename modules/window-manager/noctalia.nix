{
  inputs,
  osConfig ? null,
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.window-manager.noctalia;
  secrets = if osConfig != null && osConfig ? age then osConfig.age.secrets else { };
  hasCalendarSecret = secrets ? nextcloud-calendar;

  calendarConfig = lib.optionalAttrs hasCalendarSecret {
    calendar = {
      dedupe_events = true;
      enabled = true;

      account.nextcloud = {
        color = "primary";
        credential_source = "file";
        name = "Personnel";
        password_file = secrets.nextcloud-calendar.path;
        provider = "custom";
        server_url = "https://nextcloud.parodi.tech/remote.php/dav";
        type = "caldav";
        username = "raphael";
      };
    };
  };
  pp = pkgs.fetchurl {
    url = "https://avatars.githubusercontent.com/u/35407363?v=4";
    sha256 = "sha256-F7Y7lmrQEQjspJ41p20ZjeQKnOLRGqjcxwKDVH3OMLc=";
  };
in
{
  config = lib.mkIf cfg {
    warnings = lib.optional (!hasCalendarSecret) "noctalia: calendar disable (secrets missing)";
    home.file."Pictures/pp.png".source = pp;
    programs.noctalia = {
      enable = true;

      settings = {
        theme = {
          builtin = "Catppuccin";
          community_palette = "Oxocarbon";
          mode = "dark";
          source = "builtin";
          wallpaper_scheme = "m3-content";

          templates = {
            builtin_ids = [
              "gtk3"
              "gtk4"
              "qt"
            ];
            community_ids = [ "zen-browser" ];
          };
        };

        widget = {
          audio_visualizer = {
            bands = 19;
            show_when_idle = true;
            width = 100.0;
          };

          clock.tooltip_format = "{:%d/%m/%Y}";
          "control-center".glyph = "settings";
          launcher.custom_image_colorize = true;
          network.show_label = false;
        };

        bar.default = {
          start = [
            "control-center"
            "workspaces"
          ];
          center = [
            "clock"
            "audio_visualizer"
          ];
          end = [
            "tray"
            "notifications"
            "volume"
            "session"
          ];
          margin_ends = 10;
        };

        desktop_widgets.enabled = false;

        location.auto_locate = true;

        lockscreen.blurred_desktop = true;

        lockscreen_widgets = {
          enabled = false;
          schema_version = 2;

          grid = {
            cell_size = 16;
            major_interval = 4;
            visible = true;
          };
        };

        shell = {
          avatar_path = "/home/${config.home.username}/Pictures/pp.png";
          font_family = "FiraCode Nerd Font";
          lang = "fr";
          polkit_agent = true;
          panel.floating_offset = 3;
        };

        wallpaper.enabled = false;
      }
      // calendarConfig;
    };
  };
}
