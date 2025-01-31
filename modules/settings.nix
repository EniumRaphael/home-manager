{ config, pkgs, ... }:

{
	home.username = "raphael";
	home.homeDirectory = "/Users/raphael";
	home.stateVersion = "23.11";

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
