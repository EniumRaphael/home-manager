{ config, pkgs, lib, ... }:

{
	home.packages = with pkgs; [
		cider
		element-desktop
		revolt-desktop
		telegram-desktop
		vesktop
		vlc
	];
}
