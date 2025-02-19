{ system, inputs, config, pkgs, lib, nixvim, zen-browser, ... }:

let
	dev = import ../modules/dev/global.nix {
		inherit inputs config pkgs lib nixvim;
	};
	package = import ../modules/packages/global.nix {
		inherit system inputs config pkgs lib zen-browser;
	};
	zsh = import ../modules/shell/zsh.nix {
		inherit inputs config pkgs;
	};
in
{
	home = {
		username = "rparodi";
		homeDirectory = "/home/rparodi";
		stateVersion = "24.05";
		sessionVariables = {
			EDITOR = "neovim";
		};
	};

	nixpkgs.config.allowUnfree = true;
	
	imports = [
		dev
		package
		zsh
	];

	application = {
		enable = false;
		cider = false;
		prismlauncher = false;
		zed = false;
		zen = false;
		obs = false;
		slack = false;
		element = false;
		fonts = false;
		obsidian = false;
		openvpn = false;
		ungoogled = false;
		vesktop = false;
		vlc = false;
		firefox = false;
		cava = false;
		kitty = true;
	};

	dev = {
		enable = true;
		language = {
			c-cpp = false;
			rust = false;
		};
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
