{ config, pkgs, lib, ... }:

{
	home.packages = with pkgs; [
		element-desktop
		revolt-desktop
		vesktop
	];
}
