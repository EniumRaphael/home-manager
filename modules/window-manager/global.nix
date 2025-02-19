{ inputs, config, pkgs, lib, ... }:

let
	hyprland = import ./hyprland.nix {
		inherit inputs config pkgs lib;
	};
	hyprpaper = import ./hyprpaper.nix {
		inherit inputs config pkgs lib;
	};
	mako = import ./mako.nix {
		inherit inputs config pkgs lib;
	};
	rofi = import ./rofi.nix {
		inherit inputs config pkgs lib;
	};
	thunar = import ./thunar.nix {
		inherit inputs config pkgs lib;
	};
	waybar = import ./waybar.nix {
		inherit inputs config pkgs lib;
	};

	cfg = config.window-manager;
in
{
	imports = [
		hyprland
		hyprpaper
		mako
		rofi
		thunar
		waybar
	];

	options.window-manager = {
		enable = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable the configuration of the window-manager";
		};
		hyprland = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable the Hyprland configuration";
		};
		hyprpaper = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable the Hyprpaper configuration";
		};
		mako = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable the mako configuration";
		};
		thunar = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable the Thunar configuration";
		};
		rofi = lib.mkOption {
			type = lib.types.bool;
			default = false;
		description = "Enable the Rofi configuration";
		};
		waybar = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable the Waybar configuration";
		};
	};

	config = lib.mkIf (!config.window-manager.enable) {
		window-manager = {
			hyprland = false;
			hyprpaper = false;
			mako = false;
			rofi = false;
			waybar = false;
			thunar = false;
		};
	} // lib.mkIf cfg.enable {
		home.packages = with pkgs; [
			grim
			pavucontrol
			slurp
		];

		catppuccin.accent = "mauve";

		xdg.userDirs = {
			enable = true;
			createDirectories = true;
		};
	};
}
