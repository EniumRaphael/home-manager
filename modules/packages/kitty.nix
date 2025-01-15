{ config, pkgs, ... }:

let
	cfg = config.application.kitty;
in
{
	config = lib.mkIf cfg.enable {
		programs.kitty = {
			enable = true;
			settings = {
				confirm_os_window_close = 0;
				enable_audio_bell = false;
			};
		};	
		catppuccin.kitty.enable = true;
	};
}
