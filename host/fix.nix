{ system, inputs, config, pkgs, lib, nixvim, zen-browser, ... }:

let
	dev = import ../modules/dev/global.nix {
		inherit inputs config pkgs lib nixvim;
	};
	package = import ../modules/packages/global.nix {
		inherit system inputs config pkgs lib zen-browser;
	};
	window-manager = import ../modules/window-manager/global.nix {
		inherit inputs config pkgs lib;
	};
	zsh = import ../modules/shell/zsh.nix {
		inherit inputs config pkgs;
	};
in
{
	home = {
		username = "raphael";
		homeDirectory = "/home/raphael";
		stateVersion = "24.05";
		sessionVariables = {
			ZED_ALLOW_EMULATED_GPU=1;
			EDITOR = "nvim";
		};
	};

	nixpkgs.config.allowUnfree = true;
	
	imports = [
		dev
		package
		window-manager
		zsh
	];

	application = {
		cava = true;
		cider = true;
		element = true;
		enable = true;
		evince = true;
		fonts = true;
		imv = true;
		kitty = true;
		obs = true;
		obsidian = true;
		openvpn = true;
		prismlauncher = true;
		slack = true;
		ungoogled = true;
		vesktop = true;
		vlc = true;
		zed = true;
		zen = true;
	};

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
		mako = true;
		rofi = true;
		thunar = true;
		waybar = true;
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
	programs.home-manager.enable = true;
}
