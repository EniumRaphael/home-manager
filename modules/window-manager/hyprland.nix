{ inputs, config, pkgs, lib, ... }:

let
	cfg = config.window-manager.hyprland;
in
{
	config = lib.mkIf cfg {
		home.packages = with pkgs; [
			hyprcursor
			brightnessctl
			pamixer
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
				"inode/directory" = [ "thunar.desktop" ];
				"audio/*" = [ "vlc.desktop" ];
				"video/*" = [ "vlc.desktop" ];
				"image/jpeg" = [ "imv.desktop" ];
				"image/png" = [ "imv.desktop" ];
				"image/gif" = [ "imv.desktop" ];
				"image/webp" = [ "imv.desktop" ];
				"text/plain" = [ "dev.zed.Zed.desktop" ];
				"application/pdf" = [ "org.gnome.Evince.desktop" ];
				"x-scheme-handler/http" = [ "zen.desktop" ];
				"x-scheme-handler/https" = [ "zen.desktop" ];
			};
		};
		wayland.windowManager.hyprland = {
			enable = true;
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
					resize_on_border = false ;
					allow_tearing = false;
				};
				env = [
					"CLUTTER_BACKEND,wayland"
					"ELECTRON_OZONE_PLATFORM_HINT,auto"
					"GDK_BACKEND,wayland,x11"
					"MOZ_ENABLE_WAYLAND,1"
					"QT_AUTO_SCREEN_SCALE_FACTOR,1"
					"QT_QPA_PLATFORM,wayland;xcb"
					"QT_QPA_PLATFORM,wayland;xcb"
					"QT_QPA_PLATFORMTHEM,qt5ct"
					"QT_QPA_PLATFORMTHEME,qt6ct"
					"QT_SCALE_FACTOR,1"
					"QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
					"SDL_VIDEODRIVER,wayland"
					"XDG_CURRENT_DESKTOP,Hyprland"
					"XDG_SESSION_DESKTOP,Hyprland"
					"XDG_SESSION_TYPE,wayland"
				];
				exec-once = [
					"waybar"
					"hyprctl setcursor \"Catppuccin-Mocha-Dark\" 24"
					"vesktop"
					"pw-metadata -n settings 0 clock.force-quantum 512"
				];
				bind = [
					"$mod, RETURN, exec, ${pkgs.kitty}/bin/kitty"
					"$mod, w, exec, zen"
					"$mod, e, exec, ${pkgs.xfce.thunar}/bin/thunar"
					"$mod, b, exec, pkill Hyprland"
					"$mod, SPACE, exec, rofi -show drun"
					"$mod, q, killactive"
					"ALT, L, exec, ${pkgs.swaylock-fancy}"
					"ALT SHIFT, L, exec, ${pkgs.swaylock-fancy}"
					"$mod SHIFT, ESCAPE, exit,"
					"$mod, V, togglefloating,"
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
					"$mod SHIFT, S, exec, grim -g \"$(slurp)\" - | wl-copy"
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
				windowrulev2 = [
					"float, class:^([Rr]ofi)$"
					"float, title:^(Picture-in-Picture)$"
	
					"opacity 0.9 0.6, class:^([Rr]ofi)$"
					"opacity 0.9 0.7, class:^(Brave-browser(-beta|-dev)?)$"
					"opacity 0.9 0.7, class:^([Zz]en|[Ff]irefox|org.mozilla.firefox|[Ff]irefox-esr)$"
					"opacity 0.9 0.6, class:^([Tt]horium-browser)$"
					"opacity 0.9 0.8, class:^([Mm]icrosoft-edge(-stable|-beta|-dev|-unstable)?)$"
					"opacity 0.9 0.8, class:^(google-chrome(-beta|-dev|-unstable)?)$"
					"opacity 0.94 0.86, class:^(chrome-.+-Default)$"
					"opacity 0.9 0.8, class:^([Tt]hunar|org.gnome.Nautilus)$"
					"opacity 0.8 0.6, class:^(pcmanfm-qt)$"
					"opacity 0.8 0.7, class:^(gedit|org.gnome.TextEditor|mousepad)$"
					"opacity 0.9 0.8, class:^(deluge)$"
					"opacity 0.8 0.7, class:^(Alacritty|kitty|kitty-dropterm)$"
					"opacity 0.9 0.7, class:^(VSCodium|codium-url-handler)$"
					"opacity 0.9 0.8, class:^(nwg-look|qt5ct|qt6ct|[Yy]ad)$"
					"opacity 0.9 0.8, title:(Kvantum Manager)"
					"opacity 0.9 0.7, class:^(com.obsproject.Studio)$"
					"opacity 0.9 0.7, class:^([Aa]udacious)$"
					"opacity 0.9 0.8, class:^(VSCode|code-url-handler)$"
					"opacity 0.9 0.8, class:^(jetbrains-.+)$"
					"opacity 0.94 0.86, class:^([Cc]ider)$"
					"opacity 0.94 0.86, class:^([Ss]lack)$"
					"opacity 0.94 0.86, class:^([Rr]evolt-desktop)$"
					"opacity 0.94 0.86, class:^([Dd]iscord|[Vv]esktop)$"
					"opacity 0.9 0.8, class:^([Ee]lement)$"
					"opacity 0.9 0.8, class:^(im.riot.Riot)$"
					"opacity 0.94 0.86, class:^(gnome-disks|evince|wihotspot(-gui)?|org.gnome.baobab)$"
					"opacity 0.9 0.8, class:^(file-roller|org.gnome.FileRoller)$"
					"opacity 0.8 0.7, class:^(app.drey.Warp)$"
					"opacity 0.9 0.8, class:^(seahorse)$"
					"opacity 0.82 0.75, class:^(gnome-system-monitor|org.gnome.SystemMonitor|io.missioncenter.MissionCenter)$"
					"opacity 0.9 0.8, class:^(xdg-desktop-portal-gtk)$"
					"opacity 0.9 0.7, class:^([Ww]hatsapp-for-linux)$"
					"opacity 0.9 0.7, class:^([Ff]erdium)$"
					"opacity 0.95 0.95, title:^(Picture-in-Picture)$"
	
					"pin,title:^([Rr]ofi)$"
					"pin,title:^(Picture-in-Picture)$"
					"keepaspectratio, title:^(Picture-in-Picture)$"
	
					"workspace 7, class:^([Ss]lack)$"
					"workspace 8, class:^([Ee]lement)$"
					"workspace 9, class:^([Dd]iscord|[Ww]ebCord|[Vv]esktop)$"
					"workspace 10, class:^([Cc]ider)$"
				];
			};
		};
	};
}
