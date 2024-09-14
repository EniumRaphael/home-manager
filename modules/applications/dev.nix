{ config, pkgs, lib, ... }:

{
	home.packages = with pkgs; [
		alacritty
		zed-editor
	];
}

