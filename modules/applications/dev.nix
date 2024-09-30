{ config, pkgs, lib, ... }:

{
	home.packages = with pkgs; [
		alacritty
		wezterm
		zed-editor
	];
}

