{ config, pkgs, lib, ... }:

{
	home.packages = with pkgs; [
		cider
		element-desktop
		grim
		revolt-desktop
		slurp
		vesktop
		vlc
	];

	programs.obs-studio = {
		enable = true;
		plugins = with pkgs.obs-studio-plugins; [
			wlrobs
			obs-backgroundremoval
			obs-pipewire-audio-capture
		];
	};
}
