{ inputs, config, pkgs, lib, ... }:

let
	cfg = config.application.kitty;
in
{
	config = lib.mkIf cfg {
		home.packages = with pkgs; [
			nerd-fonts.fira-code
		];
		programs.kitty = {
			enable = true;
			font = {
				name = "FiraCode Nerd Font";
				package = pkgs.nerd-fonts.fira-code;
				size = 13;
			};
			settings = {
				disable_ligatures = "never";
				confirm_os_window_close = 0;
				enable_audio_bell = false;
			};
		};	
		catppuccin.kitty.enable = true;
	};
}
