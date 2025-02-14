{ system, inputs, config, pkgs, lib, zen-browser, ... }:

let
	cfg = pkgs.stdenv.hostPlatform.isAarch;
in
{
	config = lib.mkMerge [
		(lib.mkIf (!cfg && config.application.enable) {
			home.packages = with pkgs; [
				cider
				prismlauncher
				slack
				zen-browser
			];
			programs.obs-studio = {
				enable = true;
				plugins = with pkgs.obs-studio-plugins; [
					wlrobs
					obs-backgroundremoval
					obs-pipewire-audio-capture
				];
			};
		})

		(lib.mkIf (!cfg && config.application.enable) {
			programs.firefox.enable = true;
		})
	];
}
