{ inputs, config, pkgs, lib, ... }:

let
	cfg = config.window-manager.thunar;
in
{
	config = lib.mkIf cfg {
		home.packages = with pkgs; [
			gvfs
			xfce.thunar
			xfce.thunar-archive-plugin
			xfce.thunar-volman
			xfce.tumbler
			xfce.xfconf
		];
		catppuccin = {
			gtk = {
				enable = true;
				icon.enable = true;
			};
		};
	};
}
