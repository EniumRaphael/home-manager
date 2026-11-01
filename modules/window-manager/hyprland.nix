{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.window-manager.hyprland;
  ipc = "noctalia msg";
  mod = "SUPER";
  lua = lib.generators.mkLuaInline;
  toLua = lib.generators.toLua { multiline = false; };
  exec = cmd: "hl.dsp.exec_cmd(${builtins.toJSON cmd})";
  bind = key: dsp: opts: {
    _args = [
      key
      (lua dsp)
    ]
    ++ lib.optional (opts != { }) opts;
  };
  op = active: inactive: match: {
    inherit match;
    opacity = "${active} ${inactive}";
  };

  monitorOpen = "hl.monitor(${toLua ((lib.head cfg.monitors) // { disabled = false; })})";

  clamshell = pkgs.writeShellScriptBin "clamshell" ''
    INTERNAL_DISPLAY=${cfg.primaryMonitor}

    ICON_LAPTOP="computer-laptop"
    ICON_MONITOR="video-display"

    notify_user() {
      ${pkgs.libnotify}/bin/notify-send -i "$3" "$1" "$2"
    }

    mode_close() {
      MONITORS_COUNT=$(hyprctl monitors all | grep -c "Monitor")
      if [[ $MONITORS_COUNT -gt 1 ]]; then
        hyprctl eval "hl.monitor({ output = \"$INTERNAL_DISPLAY\", disabled = true })"
        sudo ${pkgs.systemd}/bin/systemctl stop fprintd.service
      fi
    }

    mode_open() {
      hyprctl eval '${monitorOpen}'
      sudo ${pkgs.systemd}/bin/systemctl start fprintd.service
    }

    if [[ "$1" == "close" ]]; then
      mode_close
      notify_user "Clamshell Mode" "External monitor active. Laptop screen disabled." "$ICON_MONITOR"

    elif [[ "$1" == "open" ]]; then
      mode_open
      notify_user "Laptop Mode" "Laptop screen enabled." "$ICON_LAPTOP"

    elif [[ "$1" == "check" ]]; then
      if grep -q "open" /proc/acpi/button/lid/*/state; then
        mode_open
      else
        mode_close
      fi

    else
      echo "Usage: clamshell [open|close|check]"
      exit 1
    fi
  '';

  envVars = {
    GDK_BACKEND = "wayland,x11,*";
    QT_QPA_PLATFORM = "wayland;xcb";
    CLUTTER_BACKEND = "wayland";
    SDL_VIDEODRIVER = "wayland,x11";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";

    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_QUICK_CONTROLS_STYLE = "org.hyprland.style";

    GDK_SCALE = "1";
    QT_SCALE_FACTOR = "1";

    MOZ_ENABLE_WAYLAND = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    NIXOS_OZONE_WL = "1";

    WLR_RENDERER = "vulkan";
    GAMEMODE = "1";
    MANGOHUD = "1";
    MANGOHUD_CONFIG = "cpu_temp,gpu_temp,ram,vram,fps,time";
    PROTON_USE_WINED3D = "0";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    HYPRLAND_NO_SD_NOTIFY = "1";
  }
  // lib.optionalAttrs cfg.usingNVIDIA {
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __NV_PRIME_RENDER_OFFLOAD = "1";
    __GL_SYNC_TO_VBLANK = "0";
    __GL_THREADED_OPTIMIZATIONS = "1";
    NVD_BACKEND = "direct";
  }
  // lib.optionalAttrs cfg.usingAMD {
    LIBVA_DRIVER_NAME = "radeonsi";
    VDPAU_DRIVER = "radeonsi";
  };

  startup = [
    ''hyprctl setcursor "Catppuccin-Mocha-Dark" 24''
    "pw-metadata -n settings 0 clock.force-quantum 512"
    "xrandr --output ${cfg.primaryMonitor} --primary"
    "thunderbird"
    "cider-2"
    "element-desktop"
    "sleep 2 && noctalia"
  ]
  ++ lib.optionals cfg.isLaptop [
    "upower"
    "clamshell check"
  ];

  startupFn = ''
    function()
    ${lib.concatMapStringsSep "\n" (c: "  hl.exec_cmd(${builtins.toJSON c})") startup}
    end'';
  reloadFn = ''
    function()
      hl.exec_cmd("clamshell check")
    end'';

  workspaceKeys = lib.range 1 10;
  keyOf = i: if i == 10 then "0" else toString i;

  binds = [
    (bind "${mod} + Q" "hl.dsp.window.close()" { })
    (bind "${mod} + RETURN" (exec "${pkgs.ghostty}/bin/ghostty +new-window") { })
    (bind "${mod} + W" (exec "zen-beta") { })
    (bind "${mod} + E" (exec "${pkgs.nautilus}/bin/nautilus") { })
    (bind "ALT + SPACE" (exec "${ipc} panel-toggle launcher") { })
    (bind "ALT + L" (exec "${ipc} session lock") { })
    (bind "${mod} + SHIFT + ESCAPE" "hl.dsp.exit()" { })
    (bind "${mod} + V" ''hl.dsp.window.float({ action = "toggle" })'' { })
    (bind "${mod} + F" "hl.dsp.window.fullscreen()" { })

    (bind "${mod} + H" ''hl.dsp.focus({ direction = "left" })'' { })
    (bind "${mod} + L" ''hl.dsp.focus({ direction = "right" })'' { })
    (bind "${mod} + J" ''hl.dsp.focus({ direction = "up" })'' { })
    (bind "${mod} + K" ''hl.dsp.focus({ direction = "down" })'' { })

    (bind "${mod} + Right" ''hl.dsp.focus({ workspace = "e+1" })'' { })
    (bind "${mod} + Left" ''hl.dsp.focus({ workspace = "e-1" })'' { })
    (bind "${mod} + mouse_down" ''hl.dsp.focus({ workspace = "e+1" })'' { })
    (bind "${mod} + mouse_up" ''hl.dsp.focus({ workspace = "e-1" })'' { })

    (bind "${mod} + SHIFT + S" (exec ''grim -g "$(slurp)" - | wl-copy'') { })

    (bind "XF86AudioPlay" (exec "${ipc} media toggle") { })
    (bind "XF86AudioPrev" (exec "${ipc} media previous") { })
    (bind "XF86AudioNext" (exec "${ipc} media next") { })

    (bind "${mod} + mouse:272" "hl.dsp.window.drag()" { mouse = true; })
    (bind "${mod} + mouse:273" "hl.dsp.window.resize()" { mouse = true; })

    (bind "XF86AudioLowerVolume" (exec "${ipc} volume-down 5") {
      locked = true;
      repeating = true;
    })
    (bind "XF86AudioRaiseVolume" (exec "${ipc} volume-up 5") {
      locked = true;
      repeating = true;
    })
    (bind "XF86MonBrightnessDown" (exec "${ipc} brightness-down all 5") {
      locked = true;
      repeating = true;
    })
    (bind "XF86MonBrightnessUp" (exec "${ipc} brightness-up all 5") {
      locked = true;
      repeating = true;
    })

    (bind "XF86AudioMute" (exec "${ipc} volume-mute") { locked = true; })
  ]
  ++ lib.optionals cfg.isLaptop [
    (bind "switch:on:Lid Switch" (exec "clamshell close") { locked = true; })
    (bind "switch:off:Lid Switch" (exec "clamshell open") { locked = true; })
  ]
  ++ map (
    i: bind "${mod} + ${keyOf i}" "hl.dsp.focus({ workspace = ${toString i} })" { }
  ) workspaceKeys
  ++ map (
    i: bind "${mod} + SHIFT + ${keyOf i}" "hl.dsp.window.move({ workspace = ${toString i} })" { }
  ) workspaceKeys;

  gameClass = "^(.*\\.exe|gamescope|steam_app_\\d+)$";

  windowRules = [
    (op "0.9" "0.6" { class = "^(Rofi)$"; })
    (op "0.9" "0.6" { class = "^(Vicinae)$"; })
    (op "0.9" "0.7" { class = "^(Brave-browser(-beta|-dev)?)$"; })
    (op "0.9" "0.7" { class = "^(zen-beta|Firefox|org.mozilla.firefox|Firefox-esr)$"; })
    (op "0.9" "0.6" { class = "^(Thorium-browser)$"; })
    (op "0.9" "0.8" { class = "^(Microsoft-edge(-stable|-beta|-dev|-unstable)?)$"; })
    (op "0.9" "0.8" { class = "^(google-chrome(-beta|-dev|-unstable)?)$"; })
    (op "0.94" "0.86" { class = "^(chrome-.+-Default)$"; })
    (op "0.9" "0.8" { class = "^(org.gnome.Nautilus)$"; })
    (op "0.8" "0.6" { class = "^(pcmanfm-qt)$"; })
    (op "0.8" "0.7" { class = "^(thunderbird)$"; })
    (op "0.8" "0.7" { class = "^(gedit|org.gnome.TextEditor|mousepad)$"; })
    (op "0.9" "0.8" { class = "^(deluge)$"; })
    (op "0.8" "0.7" { class = "^(Alacritty|com.mitchellh.ghostty|kitty|kitty-dropterm)$"; })
    (op "0.9" "0.7" { class = "^(VSCodium|codium-url-handler)$"; })
    (op "0.9" "0.8" { class = "^(nwg-look|qt5ct|qt6ct|Yad)$"; })
    (op "0.9" "0.8" { title = "^(Kvantum Manager)$"; })
    (op "0.9" "0.7" { class = "^(com.obsproject.Studio)$"; })
    (op "0.9" "0.7" { class = "^(Audacious)$"; })
    (op "0.9" "0.8" { class = "^(VSCode|code-url-handler)$"; })
    (op "0.9" "0.8" { class = "^(jetbrains-.+)$"; })
    (op "0.94" "0.86" { class = "^(cider)$"; })
    (op "0.94" "0.86" { class = "^(Slack)$"; })
    (op "0.94" "0.86" { class = "^(Revolt-desktop)$"; })
    (op "0.9" "0.8" { class = "^(vesktop)$"; })
    (op "0.9" "0.8" { initial_class = "^(element-desktop)$"; })
    (op "0.9" "0.8" { class = "^(im.riot.Riot)$"; })
    (op "0.94" "0.86" { class = "^(gnome-disks|evince|wihotspot(-gui)?|org.gnome.baobab)$"; })
    (op "0.9" "0.8" { class = "^(file-roller|org.gnome.FileRoller)$"; })
    (op "0.8" "0.7" { class = "^(app.drey.Warp)$"; })
    (op "0.9" "0.8" { class = "^(seahorse)$"; })
    (op "0.82" "0.75" {
      class = "^(gnome-system-monitor|org.gnome.SystemMonitor|io.missioncenter.MissionCenter)$";
    })
    (op "0.9" "0.8" { class = "^(xdg-desktop-portal-gtk)$"; })
    (op "0.9" "0.7" { class = "^(Whatsapp-for-linux)$"; })
    (op "0.9" "0.7" { class = "^(Ferdium)$"; })
    (op "0.95" "0.95" { title = "^(Picture-in-Picture)$"; })
    {
      match.class = "^(Slack)$";
      workspace = "8";
    }
    {
      match.class = "^(thunderbird)$";
      workspace = "8";
    }
    {
      match.initial_class = "^(element-desktop)$";
      workspace = "9";
    }
    {
      match.class = "^(cider)$";
      workspace = "10";
    }
    {
      match.class = gameClass;
      workspace = "11";
      fullscreen = true;
    }
    {
      match.initial_title = "^(Discord Popout)$";
      float = true;
      pin = true;
      keep_aspect_ratio = true;
    }
    {
      match.title = "^(Picture-in-Picture)$";
      float = true;
      pin = true;
      keep_aspect_ratio = true;
      size = "(monitor_w*0.3) (monitor_h*0.3)";
    }
    {
      match.class = "^(Mullvad VPN)$";
      move = "(monitor_w-321) 42";
      float = true;
      pin = true;
    }
    {
      match.class = "^(gcr-prompter)$";
      pin = true;
    }
  ];
in
{
  config = lib.mkIf cfg.enable {

    home.packages =
      with pkgs;
      [
        hyprcursor
        brightnessctl
        pamixer
        wl-clipboard
        xrandr
        libinput
        libinput-gestures
      ]
      ++ lib.optionals cfg.isLaptop [ clamshell ];

    home.pointerCursor.enable = true;

    catppuccin = {
      hyprland.enable = false;
      cursors = {
        enable = true;
        accent = "dark";
      };
    };

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
        "audio/*" = [ "vlc.desktop" ];
        "video/*" = [ "vlc.desktop" ];
        "image/jpeg" = [ "imv.desktop" ];
        "image/png" = [ "imv.desktop" ];
        "image/gif" = [ "imv.desktop" ];
        "image/webp" = [ "imv.desktop" ];
        "text/plain" = [ "nvim.desktop" ];
        "application/pdf" = [ "org.gnome.Evince.desktop" ];
        "x-scheme-handler/http" = [ "zen-beta.desktop" ];
        "x-scheme-handler/https" = [ "zen-beta.desktop" ];
        "x-scheme-handler/mailto" = [ "thunderbird.desktop" ];
        "message/rfc822" = [ "thunderbird.desktop" ];
        "x-scheme-handler/mid" = [ "thunderbird.desktop" ];
        "application/zip" = "org.gnome.FileRoller.desktop";
        "application/x-tar" = "org.gnome.FileRoller.desktop";
        "application/x-compressed-tar" = "org.gnome.FileRoller.desktop";
        "application/x-rar" = "org.gnome.FileRoller.desktop";
        "application/x-7z-compressed" = "org.gnome.FileRoller.desktop";
        "application/gzip" = "org.gnome.FileRoller.desktop";
        "application/x-bzip2" = "org.gnome.FileRoller.desktop";
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      configType = "lua";
      systemd.enable = true;
      xwayland.enable = true;

      settings = {
        config = {
          general = {
            gaps_in = 5;
            gaps_out = 20;
            border_size = 2;
            col = {
              active_border = {
                colors = [
                  "rgba(cba6f7ee)"
                  "rgba(89b4faee)"
                ];
                angle = 45;
              };
              inactive_border = "rgba(181825aa)";
            };
            resize_on_border = false;
            allow_tearing = false;
          };
          decoration.rounding = 8;
        }
        // lib.optionalAttrs cfg.isLaptop {
          input.touchpad = {
            natural_scroll = true;
            disable_while_typing = true;
          };
        };

        env = lib.mapAttrsToList (name: value: {
          _args = [
            name
            value
          ];
        }) envVars;

        monitor = cfg.monitors;
        workspace_rule = cfg.workspaces;

        gesture = lib.optionals cfg.isLaptop [
          {
            fingers = 4;
            direction = "horizontal";
            action = "workspace";
          }
          {
            fingers = 3;
            direction = "horizontal";
            action = "workspace";
          }
        ];

        bind = binds;
        window_rule = windowRules;

        on = [
          {
            _args = [
              "hyprland.start"
              (lua startupFn)
            ];
          }
        ]
        ++ lib.optionals cfg.isLaptop [
          {
            _args = [
              "config.reloaded"
              (lua reloadFn)
            ];
          }
        ];
      };
    };
  };
}
