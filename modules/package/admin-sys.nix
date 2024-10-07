{ config, pkgs, lib, ... }:

{
	home.packages = with pkgs; [
		btop
		eza
		fastfetch
		htop
		ncdu
		onefetch
		openvpn
		ripgrep
		tree
	];
}
