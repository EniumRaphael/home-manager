{ config, pkgs, lib, ... }:

let
	installation = import ./modules/install.nix { inherit config pkgs lib; };
	settings = import ./modules/settings.nix { inherit config pkgs lib; };
in
{
	imports = [
		installation
		settings
	];
}
