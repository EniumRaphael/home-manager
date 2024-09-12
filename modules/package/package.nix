{ config, pkgs, lib, ... }:

let
	admin-sys = import ./admin-sys.nix { inherit config pkgs lib; };
	cyber = import ./cyber.nix { inherit config pkgs lib; };
	dev = import ./dev.nix { inherit config pkgs lib; };
	shell = import ./zsh.nix { inherit config pkgs lib; };
in
{
	imports = [
		admin-sys
		cyber
		dev
		shell
	];
}
