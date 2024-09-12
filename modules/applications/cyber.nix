{ config, pkgs, lib, ... }:

{
	home.packages = with pkgs; [
		burp
		metasploit
	];
}
