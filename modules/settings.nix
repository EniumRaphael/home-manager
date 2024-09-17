{ config, pkgs, ... }:

{
	home.username = "raphael";
	home.homeDirectory = "/home/raphael";
	home.stateVersion = "23.11";

	targets.genericLinux.enable = true;
	programs.home-manager.enable = true;

	fonts = {
		fontconfig = {
			defaultFonts = {
				serif = ["JetBrainsMono Nerd Font"];
				sansSerif = ["JetBrainsMono Nerd Font"];
				monospace = ["JetBrainsMono Nerd Font"];
			};
		};
	};
}
