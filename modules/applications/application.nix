{ config, pkgs, lib, ... }:

let
	dev = import ./dev.nix { inherit config pkgs lib; };
	cyber = import ./cyber.nix { inherit config pkgs lib; };
	social = import ./social.nix { inherit config pkgs lib; };
in
{
	imports = [
		dev
		cyber
		social
	];
}
