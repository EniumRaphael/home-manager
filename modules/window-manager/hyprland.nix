{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.window-manager.hyprland;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      hyprcursor
      brightnessctl
      pamixer
      wl-clipboard
      xrandr
    ];
    catppuccin = {
      hyprland.enable = true;
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
      };
    };
    wayland.windowManager.hyprland = {
      enable = true;
      systemd = {
        enable = false;
        variables = [
          "--all"
        ];
      };
      xwayland.enable = true;
      settings = {
        "$mod" = "SUPER";
        decoration = {
          rounding = 8;
        };
        general = {
          gaps_in = 5;
          gaps_out = 20;
          border_size = 2;
          "col.active_border" = "rgba(cba6f7ee) rgba(89b4faee) 45deg";
          "col.inactive_border" = "rgba(181825aa)";
          resize_on_border = false;
          allow_tearing = false;
        };
        monitor = cfg.monitors;
        env = [
          "GDK_BACKEND=wayland,x11,*"
          "QT_QPA_PLATFORM=wayland;xcb"
          "CLUTTER_BACKEND=wayland"
          "SDL_VIDEODRIVER=wayland,x11"
          "XDG_CURRENT_DESKTOP=Hyprland"
          "XDG_SESSION_DESKTOP=Hyprland"
          "XDG_SESSION_TYPE=wayland"

          "QT_AUTO_SCREEN_SCALE_FACTOR=1"
          "QT_WAYLAND_DISABLE_WINDOWDECORATION=1"
          "QT_QPA_PLATFORMTHEME=qt6ct"
          "QT_QUICK_CONTROLS_STYLE=org.hyprland.style"

          "GDK_SCALE=1"
          "QT_SCALE_FACTOR=1"

          "MOZ_ENABLE_WAYLAND=1"
          "ELECTRON_OZONE_PLATFORM_HINT=auto"

          "LIBVA_DRIVER_NAME=nvidia"
          "__GLX_VENDOR_LIBRARY_NAME=nvidia"
          "__NV_PRIME_RENDER_OFFLOAD=1"
          "__GL_SYNC_TO_VBLANK=0"
          "__GL_THREADED_OPTIMIZATIONS=1"
          "NVD_BACKEND=direct"
          "WLR_RENDERER=vulkan"
          "GAMEMODE=1"
          "MANGOHUD=1"
          "MANGOHUD_CONFIG=cpu_temp,gpu_temp,ram,vram,fps,time"
          "PROTON_USE_WINED3D=0"
          "_JAVA_AWT_WM_NONREPARENTING=1"
          "HYPRLAND_NO_SD_NOTIFY=1"
        ];
        exec-once = [
          "waybar"
          ''hyprctl setcursor "Catppuccin-Mocha-Dark" 24''
          "hyprpaper"
          "vicinae server"
          "pw-metadata -n settings 0 clock.force-quantum 512"
          "thunderbird"
          "cider-2"
          "vesktop --ozone-platform-hint=auto"
          "mullvad-vpn"
          "xrandr --output ${cfg.primaryMonitor} --primary"
        ];
        bind = [
          "$mod, RETURN, exec, ${pkgs.kitty}/bin/kitty"
          "$mod, w, exec, zen-beta"
          "$mod, e, exec, ${pkgs.nautilus}/bin/nautilus"
          "$mod, b, exec, vicinae toggle -q 'power system'"
          "ALT, SPACE, exec, ${pkgs.vicinae}/bin/vicinae toggle"
          "$mod, q, killactive"
          "ALT, L, exec, ${pkgs.hyprlock}/bin/hyprlock"
          "$mod SHIFT, ESCAPE, exit,"
          "$mod, V, togglefloating,"
          "$mod, F, fullscreen"
          "$mod, R, exec, $menu"
          "$mod, P, togglesplit"
          "$mod, h, movefocus, l"
          "$mod, l, movefocus, r"
          "$mod, j, movefocus, u"
          "$mod, k, movefocus, d"
          "$mod, Right, workspace, e+1"
          "$mod, Left, workspace, e-1"
          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"
          ''$mod SHIFT, S, exec, grim -g "$(slurp)" - | wl-copy''
          ",XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
          ",XF86AudioStop, exec, ${pkgs.playerctl}/bin/playerctl stop"
          ",XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous"
          ",XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
          ",XF86AudioMute, exec, ${pkgs.pamixer}/bin/pamixer -t"
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"
          "$mod, 0, workspace, 10"
          "$mod SHIFT, 1, movetoworkspace, 1"
          "$mod SHIFT, 2, movetoworkspace, 2"
          "$mod SHIFT, 3, movetoworkspace, 3"
          "$mod SHIFT, 4, movetoworkspace, 4"
          "$mod SHIFT, 5, movetoworkspace, 5"
          "$mod SHIFT, 6, movetoworkspace, 6"
          "$mod SHIFT, 7, movetoworkspace, 7"
          "$mod SHIFT, 8, movetoworkspace, 8"
          "$mod SHIFT, 9, movetoworkspace, 9"
          "$mod SHIFT, 0, movetoworkspace, 10"
        ];
        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
        binde = [
          ",XF86AudioLowerVolume, exec, pamixer -d 5"
          ",XF86AudioRaiseVolume, exec, pamixer -i 5"
          ",XF86MonBrightnessDown, exec, brightnessctl set 10%-"
          ",XF86MonBrightnessUp, exec, brightnessctl set 10%+ "
        ];
        workspace = [
          "1, monitor:HDMI-A-1"
          "2, monitor:HDMI-A-1"
          "3, monitor:HDMI-A-1"
          "4, monitor:HDMI-A-1"
          "5, monitor:HDMI-A-1"
          "6, monitor:DP-1"
          "7, monitor:DP-1"
          "8, monitor:DP-1"
          "9, monitor:DP-1"
          "10, monitor:DP-1"
          "11, monitor:HDMI-A-1, border:false, rounding:false"
        ];
        windowrule = [
          "opacity 0.9 0.6, match:class ^(Rofi)$"
          "opacity 0.9 0.6, match:class ^(Vicinae)$"
          "opacity 0.9 0.7, match:class ^(Brave-browser(-beta|-dev)?)$"
          "opacity 0.9 0.7, match:class ^(zen-beta|Firefox|org.mozilla.firefox|Firefox-esr)$"
          "opacity 0.9 0.6, match:class ^(Thorium-browser)$"
          "opacity 0.9 0.8, match:class ^(Microsoft-edge(-stable|-beta|-dev|-unstable)?)$"
          "opacity 0.9 0.8, match:class ^(google-chrome(-beta|-dev|-unstable)?)$"
          "opacity 0.94 0.86, match:class ^(chrome-.+-Default)$"
          "opacity 0.9 0.8, match:class ^(org.gnome.Nautilus)$"
          "opacity 0.8 0.6, match:class ^(pcmanfm-qt)$"
          "opacity 0.8 0.7, match:class ^(thunderbird)$"
          "opacity 0.8 0.7, match:class ^(gedit|org.gnome.TextEditor|mousepad)$"
          "opacity 0.9 0.8, match:class ^(deluge)$"
          "opacity 0.8 0.7, match:class ^(Alacritty|kitty|kitty-dropterm)$"
          "opacity 0.9 0.7, match:class ^(VSCodium|codium-url-handler)$"
          "opacity 0.9 0.8, match:class ^(nwg-look|qt5ct|qt6ct|Yad)$"
          "opacity 0.9 0.8, match:title ^(Kvantum Manager)$"
          "opacity 0.9 0.7, match:class ^(com.obsproject.Studio)$"
          "opacity 0.9 0.7, match:class ^(Audacious)$"
          "opacity 0.9 0.8, match:class ^(VSCode|code-url-handler)$"
          "opacity 0.9 0.8, match:class ^(jetbrains-.+)$"
          "opacity 0.94 0.86, match:class ^(Cider)$"
          "opacity 0.94 0.86, match:class ^(Slack)$"
          "opacity 0.94 0.86, match:class ^(Revolt-desktop)$"
          "opacity 0.9 0.8, match:class ^(vesktop)$"
          "opacity 0.9 0.8, match:class ^(Element)$"
          "opacity 0.9 0.8, match:class ^(im.riot.Riot)$"
          "opacity 0.94 0.86, match:class ^(gnome-disks|evince|wihotspot(-gui)?|org.gnome.baobab)$"
          "opacity 0.9 0.8, match:class ^(file-roller|org.gnome.FileRoller)$"
          "opacity 0.8 0.7, match:class ^(app.drey.Warp)$"
          "opacity 0.9 0.8, match:class ^(seahorse)$"
          "opacity 0.82 0.75, match:class ^(gnome-system-monitor|org.gnome.SystemMonitor|io.missioncenter.MissionCenter)$"
          "opacity 0.9 0.8, match:class ^(xdg-desktop-portal-gtk)$"
          "opacity 0.9 0.7, match:class ^(Whatsapp-for-linux)$"
          "opacity 0.9 0.7, match:class ^(Ferdium)$"
          "opacity 0.95 0.95, match:title ^(Picture-in-Picture)$"

          "workspace 8, match:class ^(Slack)$"
          "workspace 8, match:class ^(thunderbird)$"
          "workspace 9, match:class ^(Element)$"
          "workspace 9, match:class ^(vesktop)$"
          "workspace 10, match:class ^(Cider)$"

          "workspace 11, match:class ^(.*\.exe|gamescope|steam_app_\\d+)$"
          "fullscreen 1, match:class ^(.*\.exe|gamescope|steam_app_\\d+)$"

          "float 1, match:initial_title ^(Discord Popout)"
          "pin 1, match:initial_title ^(Discord Popout)$"

          "float 1, match:title ^(Picture-in-Picture)$"
          "pin 1, match:title ^(Picture-in-Picture)$"
          "keep_aspect_ratio 1, match:title ^(Picture-in-Picture)$"
          "size = (monitor_w*0.3) (monitor_h*0.3), match:title ^(Picture-in-Picture)$"

          "move 1593 42, match:class ^(Mullvad VPN)$"
          "workspace 1, match:class ^(Mullvad VPN)$"
          "float 1, match:class ^(Mullvad VPN)$"
        ];
      };
    };
  };
}
