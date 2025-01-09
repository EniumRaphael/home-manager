{ inputs, config, pkgs, lib, ... }:

let
	cfg = config.window-manager.hyprpaper;
in
{
	config = lib.mkIf cfg {
		services.hyprpaper = {
			enable = true;
			settings = {
				ipc = "on";
				splash = false;
				splash_offset = 2.0;
			
				preload =
					[ "~/Pictures/CLM/banner.png" ];
			
				wallpaper = [
					",~/Pictures/CLM/banner.png"
				];
			};
		};
	};
}
