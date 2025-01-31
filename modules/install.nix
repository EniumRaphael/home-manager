{ config, pkgs, lib, ... }:

let
	application = import ./applications/application.nix { inherit config pkgs lib; };
	package = import ./package/package.nix { inherit config pkgs lib; };
in
{
	imports = [
		application
		package
	];

	home.packages = with pkgs; [
		git
		nerd-fonts-fira-code
	];
}
