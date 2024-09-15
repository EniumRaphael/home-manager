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
}
