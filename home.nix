{ inputs, config, pkgs, lib, nixvim, ... }:

let
	dev = import ./modules/dev/global.nix {
		inherit inputs config pkgs lib;
	};

	window-manager = import ./modules/window-manager/global.nix {
		inherit inputs config pkgs lib;
	};

	# Package
	cava = import ./modules/packages/cava.nix {
		inherit inputs config pkgs;
	};
	kitty = import ./modules/packages/kitty.nix {
		inherit inputs config pkgs;
	};

	# Shell
	zsh = import ./modules/shell/zsh.nix {
		inherit inputs config pkgs;
	};
in
{
	home = {
		username = "raphael";
		homeDirectory = "/home/raphael";
		stateVersion = "24.05";
		packages = with pkgs; [

			# Application
			cider
			element-web
			lunar-client
			obsidian
			vesktop
			vlc

			# Package
			bat
			nixvim
			openvpn

			# Fonts
			nerd-fonts.fira-code
			nerd-fonts.jetbrains-mono
		];
	};

	nixpkgs.config.allowUnfree = true;
	
	imports = [
		dev
		window-manager
		zsh

		cava
		kitty
	];

	dev = {
		enable = true;
		language = {
			c-cpp = true;
			rust = true;
		};
	};

	window-manager = {
		enable = true;
		hyprland = true;
		hyprpaper = true;
		rofi = true;
		waybar = true;
		thunar = true;
	};

	services = {
	};

	catppuccin = {
		# Pacakge
		accent = "mauve";
		kitty.enable = true;
		bat.enable = true;
	};


	home.file = {
	};

	home.sessionVariables = {
		EDITOR = "neovim";
	};

	fonts.fontconfig.enable = true;
	programs.home-manager.enable = true;
}
