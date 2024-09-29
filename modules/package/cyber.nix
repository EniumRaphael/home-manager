{ config, pkgs, lib, ... }:

{
	home.packages = with pkgs; [
		thc-hydra
		inetutils
		john
		nmap
		seclists
	];
}
