{ inputs, config, pkgs, lib, ... }:

let
	cfg = config.window-manager.mako;
in
{
	config = lib.mkIf cfg {
		catppuccin.mako.enable = true;
		services.mako = {
			enable = true;
		};
	};
}
