{ config, pkgs, ... }:

{
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
}
