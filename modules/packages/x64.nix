{ inputs, config, pkgs, lib, nixvim, zen-browser, ... }:

let
  cfg = config.system.architecture == "x86_64";
in
{
	config = lib.mkIf cfg {
		home.packages = with pkgs; [
			cider
			lunar-client
			zen-browser
		];
		wayland.windowManager.hyprland = {
			settings = {
				bind = [
					"$mod, w, exec, zen"
				];
			};
		};
	} // lib.mkIf (!cfg) {
		programs.firefox.enable = true;
		wayland.windowManager.hyprland = {
			settings = {
				bind = [
					"$mod, w, exec, firefox"
				];
			};
		};
	};
}
