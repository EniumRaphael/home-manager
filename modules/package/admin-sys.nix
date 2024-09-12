{ config, pkgs, lib, ... }:

{
	home.packages = with pkgs; [
		btop
		eza
		htop
		ncdu
		neofetch
		openvpn
		ripgrep
		tree
	];
}
