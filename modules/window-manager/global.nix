{ inputs, config, pkgs, lib, zen-browser, ... }:

let
	hyprland = import ./hyprland.nix {
		inherit inputs config pkgs lib;
	};
	hyprlock = import ./hyprpaper.nix {
		inherit inputs config pkgs lib;
	};
	hyprpaper = import ./hyprpaper.nix {
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
			rofi = false;
			waybar = false;
			thunar = false;
		};
	} // lib.mkIf cfg.enable {
		home.packages = with pkgs; [
				grim
				pavucontrol
				slurp
				zen-browser
			];

		catppuccin.accent = "mauve";

		xdg.userDirs = {
			enable = true;
			createDirectories = true;
		};
	};
}
