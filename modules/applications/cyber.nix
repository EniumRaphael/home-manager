{ config, pkgs, lib, ... }:

{
	home.packages = with pkgs; [
		burp
		freerdp
		metasploit
		wireshark
	];
}
