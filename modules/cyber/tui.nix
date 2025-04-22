{ inputs, config, pkgs, lib, ... }:

let
	cfg = config.cyber.tui;
in
{
	config = lib.mkIf cfg {
		home = {
			packages = with pkgs; [
				dirb
				ffuf
				gobuster
				hashcat
				hexedit
				holehe
				ipinfo
				john
				imagemagick
				maigret
				netcat
				nmap
				pwncat
				rustscan
			] ++ ( if pkgs.stdenv.isLinux then [
					hydra
					traceroute
				] else []);
		};
	};
}
