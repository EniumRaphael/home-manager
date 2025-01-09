{ inputs, config, pkgs, lib, ... }:

let
	cfg = config.window-manager.waybar;
in
{
	config = lib.mkIf cfg {
		catppuccin = {
			waybar = {
				enable = true;
				mode = "createLink";
			};
		};
		programs.waybar = {
			enable = true;
			settings.mainBar = {
				layer = "top";
				position = "top";
				height = 34;
				output = [
					"eDP-1"
					"HDMI-A-1"
				];
				modules-left = [
					"custom/logo"
					"hyprland/workspaces"
				];
				modules-center = [
					"clock"
					"custom/spacer"
					"cava"
				];
				modules-right = [
					"pulseaudio"
					"custom/power"
				];
				"custom/spacer" = {
					"format" = " | ";
				};
				"custom/power" = {
					"format" = "󰤆";
					"tooltip" = false;
					"on-click" = "pkill hyprland";
				};
				"custom/logo" = {
					"format" = "  ";
					"tooltip" = false;
					"on-click" = "rofi -show drun";
				};
				"clock" = {
					tooltip-format = "{calendar}";
					format-alt = "  {:%a, %d %b %Y}";
					format = "  {:%H:%M}";
				};
				"hyprland/workspaces" = {
					"on-click" = "activate";
					"format" = "{icon}";
				};
				"pulseaudio" = {
					"format" = "{icon}  ({volume}%)";
					"format-bluetooth" = "󰂰";
					"nospacing" = 1;
					"tooltip-format" = "Volume : {volume}%";
					"format-muted" = "󰝟";
					"format-icons" = {
						"headphone" = "";
						"default" = [
							"󰖀"
							"󰕾"
							""
						];
					};
					"on-click" = "pavucontrol";
					"on-click-right" = "pamixer -t";
					"scroll-step" = 1;
				};
				"cava" = {
					"framerate" = 60;
					"autosens" = 0;
					"sensitivity" = 69;
					"bars" = 21;
					"lower_cutoff_freq" = 50;
					"higher_cutoff_freq" = 10000;
					"method" = "pulse";
					"source" = "auto";
					"stereo" = false;
					"reverse" = false;
					"bar_delimiter" = 0;
					"monstercat" = false;
					"waves" = true;
					"noise_reduction" = 0.42;
					"input_delay" = 2;
					"format-icons"  = [
						"▁"
						"▂"
						"▃"
						"▄"
						"▅"
						"▆"
						"▇"
						"█"
					];
					"actions" = {
						"on-click-right" = "mode";
					};
				};
			};
			style = ''
				* {
					border: none;
					border-radius: 0;
					min-height: 0;
					font-family: JetBrainsMono Nerd Font;
					font-size: 13px;
				}
	
				window#waybar {
					background-color: #181825;
					transition-property: background-color;
					transition-duration: 0.5s;
				}
	
				window#waybar.hidden {
					opacity: 0.5;
				}
	
				#workspaces {
					background-color: transparent;
				}
	
				#custom-spacer {
					color: #cba6f7;
				}
	
				#cava {
					color: #cba6f7;
					background-color: transparent;
				}
	
				#workspaces button {
					all: initial;
					/* remove gtk theme values (waybar #1351) */
					min-width: 0;
					/* fix weird spacing in materia (waybar #450) */
					box-shadow: inset 0 -3px transparent;
					/* use box-shadow instead of border so the text isn't offset */
					padding: 6px 18px;
					margin: 6px 3px;
					border-radius: 4px;
					background-color: #1e1e2e;
					color: #cdd6f4;
				}
	
				#workspaces button.active {
					color: #1e1e2e;
					background-color: #cdd6f4;
				}
	
				#workspaces button:hover {
					box-shadow: inherit;
					text-shadow: inherit;
					color: #1e1e2e;
					background-color: #cdd6f4;
				}
	
				#workspaces button.urgent {
					background-color: #f38ba8;
				}
	
				#memory,
				#custom-power,
				#battery,
				#backlight,
				#pulseaudio,
				#network,
				#clock,
				#tray {
					border-radius: 4px;
					margin: 6px 3px;
					padding: 6px 12px;
					background-color: #1e1e2e;
					color: #181825;
				}
	
				#custom-power {
					margin-right: 6px;
				}
	
				#custom-logo {
					padding-right: 7px;
					padding-left: 7px;
					margin-left: 5px;
					font-size: 15px;
					border-radius: 8px 0px 0px 8px;
					color: #1793d1;
				}
	
				#memory {
					background-color: #fab387;
				}
	
				#battery {
					background-color: #f38ba8;
				}
	
				#battery.warning,
				#battery.critical,
				#battery.urgent {
					background-color: #ff0000;
					color: #FFFF00;
				}
	
				#battery.charging {
					background-color: #a6e3a1;
					color: #181825;
				}
	
				#backlight {
					background-color: #fab387;
				}
	
				#pulseaudio {
					background-color: #f9e2af;
				}
	
				#network {
					background-color: #94e2d5;
					padding-right: 17px;
				}
	
				#clock {
					font-family: JetBrainsMono Nerd Font;
					background-color: #cba6f7;
				}
	
				#custom-power {
					background-color: #f2cdcd;
				}
	
	
				tooltip {
					border-radius: 8px;
					padding: 15px;
					background-color: #131822;
				}
	
				tooltip label {
					padding: 5px;
					background-color: #131822;
				}
			'';
		};
	};
}
