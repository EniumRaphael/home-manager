{ system, inputs, config, pkgs, lib, zen-browser, ... }:

let
  cfg = pkgs.stdenv.hostPlatform.system == "x86_64-linux";
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
