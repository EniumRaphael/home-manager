{ config, pkgs, lib, ... }:

{
	home.packages = with pkgs; [
		hydra
		john
		nmap
		seclists
	];
}
