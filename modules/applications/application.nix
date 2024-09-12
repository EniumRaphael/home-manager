{ config, pkgs, lib, ... }:

let
	cyber = import ./cyber.nix { inherit config pkgs lib; };
	social = import ./social.nix { inherit config pkgs lib; };
in
{
	imports = [
		cyber
		social
	];
}
