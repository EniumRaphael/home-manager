{ system, inputs, config, pkgs, lib, nixvim, zen-browser, ... }:

let
	cyber = import ../modules/cyber/global.nix {
		inherit inputs config pkgs lib nixvim;
	};
	dev = import ../modules/dev/global.nix {
		inherit inputs config pkgs lib nixvim;
	};
	package = import ../modules/packages/global.nix {
		inherit system inputs config pkgs lib zen-browser;
	};
	zsh = import ../modules/shell/zsh.nix {
		inherit inputs config pkgs lib;
	};
in
{
	home = {
		username = "rparodi";
		homeDirectory = "/home/rparodi";
		stateVersion = "24.05";
		sessionVariables = {
			ZED_ALLOW_EMULATED_GPU=1;
			EDITOR = "nvim";
		};
	};

	nixpkgs.config.allowUnfree = true;
	
	imports = [
		cyber
		dev
		package
		zsh
	];

	application = {
		cava = false;
		cider = false;
		element = false;
		enable = false;
		evince = false;
		fonts = false;
		imv = false;
		kitty = true;
		obs = false;
		obsidian = false;
		openvpn = false;
		prismlauncher = false;
		slack = false;
		ungoogled = false;
		vesktop = false;
		vlc = false;
		zed = false;
		zen = true;
	};

	dev = {
		enable = true;
		language = {
			c-cpp = false;
			rust = false;
		};
	};

	cyber = {
		tui = false;
		gui = false;
	};

	catppuccin.accent = "mauve";

	fonts.fontconfig = {
		enable = true;
		defaultFonts = {
			serif = [
				"FiraCode Nerd Font"
			];
			sansSerif = [
				"FiraCode Nerd Font"
			];
			monospace = [
				"FiraCode Nerd Font"
			];
			emoji = [
				"FiraCode Nerd Font"
			];
		};
	};
}
