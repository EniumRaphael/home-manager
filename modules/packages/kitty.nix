{ inputs, config, pkgs, lib, ... }:

let
	cfg = config.application.kitty;
in
{
	config = lib.mkIf cfg {
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
