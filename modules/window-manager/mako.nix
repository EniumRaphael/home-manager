{ inputs, config, pkgs, lib, ... }:

let
	cfg = config.window-manager.mako;
in
{
	config = lib.mkIf cfg {
		home.packages = with pkgs; [
			nerd-fonts.fira-code
		];
		catppuccin.mako.enable = true;
		services.mako = {
			enable = true;
			font = "FiraCode Nerd Font 12";
			defaultTimeout = 5000;
		};
	};
}
